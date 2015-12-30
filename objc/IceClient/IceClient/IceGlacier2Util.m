//
//  IceGlacier2Util.m
//  test
//
//  Created by 邓燎燕 on 15/12/21.
//  Copyright © 2015年 邓燎燕. All rights reserved.
//

#import "IceGlacier2Util.h"

static id<ICECommunicator> communicator;
static id<GLACIER2RouterPrx> router;
static id<GLACIER2SessionPrx> glacier2session;
static NSMutableDictionary * cls2PrxMap;
static UInt64 lastAccessTimestamp;
static int idleTimeOutSeconds;
static NSThread *monitorThread;
static BOOL stoped;
static BOOL waited;

static NSTimer * timer;

@interface IceGlacier2Util ()

@end

@implementation IceGlacier2Util

+ (id<ICECommunicator>) getICECommunicator {
    if (communicator == nil) {
        @synchronized(@"communicator"){
            ICEInitializationData* initData = [ICEInitializationData initializationData];
            idleTimeOutSeconds = 30;
            initData.properties = [ICEUtil createProperties];
            [initData.properties load:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"glacier2_config.client"]];
            
            initData.dispatcher = ^(id<ICEDispatcherCall> call, id<ICEConnection> con) {
                dispatch_sync(dispatch_get_main_queue(), ^ { [call run]; });
            };
            
            communicator = [ICEUtil createCommunicator:initData];
            waited = YES;
            [IceGlacier2Util createSession];
            [IceGlacier2Util createMonitoerThread];
        }
    }
    lastAccessTimestamp = [[NSDate date] timeIntervalSince1970]*1000;
    return communicator;
}

+ (void) closeCommunicator:(BOOL)removeServiceCache{
    @synchronized(@"communicator"){
        if(communicator != nil){
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
                if (communicator != nil) {
                    [IceGlacier2Util safeShutdown];
                    stoped = YES;
                    if(removeServiceCache && cls2PrxMap!=nil && [cls2PrxMap count]!=0){
                        [cls2PrxMap removeAllObjects];
                    }
                }
            });
        }
    }
}

+(void) safeShutdown{
    @try{
        if(timer!=nil){
            [timer invalidate];
            timer = nil;
        }
        if(router!=nil){
            [router destroySession];
        }
    }@catch(ICEException* ex){
    }
    
    @try{
        [communicator destroy];
    }@catch(ICEException* ex){
    }@finally{
        communicator = nil;
    }
}


+ (void)serviceAsync:(dispatch_block)block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        while (waited) {
            [NSThread sleepForTimeInterval:0.1f];
        }
        block();
    });
}


+ (id<ICEObjectPrx>) getServicePrx:(NSString*)serviceName class:(Class)serviceCls{
    id<ICEObjectPrx> proxy = [cls2PrxMap objectForKey:serviceName];
    if(proxy != nil){
        lastAccessTimestamp = [[NSDate date] timeIntervalSince1970]*1000;
        return proxy;
    }
    proxy = [IceGlacier2Util createIceProxy:[IceGlacier2Util getICECommunicator] serviceName:serviceName class:serviceCls];
    [cls2PrxMap setObject:proxy forKey:serviceName];
    lastAccessTimestamp = [[NSDate date] timeIntervalSince1970]*1000;
    return proxy;
}

+ (id<ICEObjectPrx>) createIceProxy:(id<ICECommunicator>)c serviceName:(NSString*)serviceName class:(Class)serviceCls {
    
    id<ICEObjectPrx> proxy = nil;
    @try{
        ICEObjectPrx* base = [communicator stringToProxy:serviceName];
        NSLog(@"base Identity:\nname:%@ category:%@",[base ice_getIdentity].name,[base ice_getIdentity].category);
        base = [base ice_invocationTimeout:5000];
        SEL selector = NSSelectorFromString(@"checkedCast:");
        proxy = [serviceCls performSelector:selector withObject:base];
        return proxy;
    } @catch(ICEEndpointParseException* ex) {
        return ex;
    } @catch(ICEException* ex) {
        return ex;
    }@catch(NSException* ex){
        return ex;
    }
}

+(void)refreshSession{
    [router refreshSession];
}

+(void) createSession{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        @try {
            id<ICERouterPrx> r = [communicator getDefaultRouter];
            router = [GLACIER2RouterPrx checkedCast:r];
            glacier2session = [router createSession:@"dly" password:@"123456"];
            
            NSLog(@"SessionTimeout:%ld",[router getSessionTimeout]);
            
            timer = [NSTimer timerWithTimeInterval:5000 target:self selector:@selector(refreshSession) userInfo:nil repeats:YES];
            [timer fire];
            
        } @catch(GLACIER2CannotCreateSessionException* ex) {
            NSString* s = [NSString stringWithFormat:@"Session creation failed: %@", ex.reason_];
            dispatch_async(dispatch_get_main_queue(), ^ {
                NSLog(@"error:%@",s);
            });
        } @catch(GLACIER2PermissionDeniedException* ex) {
            NSString* s = [NSString stringWithFormat:@"Login failed: %@", ex.reason_];
            dispatch_async(dispatch_get_main_queue(), ^ {
                NSLog(@"error:%@",s);
            });
        } @catch(ICEEndpointParseException* ex) {
            NSString* s = [NSString stringWithFormat:@"Invalid router: %@", ex.reason];
            dispatch_async(dispatch_get_main_queue(), ^ {
                NSLog(@"error:%@",s);
            });
        } @catch(ICEException* ex) {
            dispatch_async(dispatch_get_main_queue(), ^ {
                NSLog(@"error:%@",[ex description]);
            });
        } @finally{
            waited = NO;
        }
    });
}


+ (void)createMonitoerThread{
    stoped = NO;
    monitorThread = [[NSThread alloc]initWithTarget:self selector:@selector(monitor) object:nil];
    [monitorThread start];
}

+ (void) monitor{
    while(!stoped){
        @try{
            // 让当前线程睡眠 5.0 秒
            [NSThread sleepForTimeInterval:5.0f];
            UInt64 nowTime = [[NSDate date] timeIntervalSince1970]*1000;
            if(lastAccessTimestamp + idleTimeOutSeconds * 1000L < nowTime){
                [IceGlacier2Util closeCommunicator:true];
            }
        }@catch(NSException * e){
            NSLog(@"%@",[e description]);
        }
    }
}

@end