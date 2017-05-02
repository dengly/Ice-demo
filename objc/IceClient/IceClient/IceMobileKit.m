//
//  IceMobileKit.m
//  IceMobileKit
//
//  Created by 邓燎燕 on 16/3/17.
//  Copyright © 2016年 邓燎燕. All rights reserved.
//

#import "IceMobileKit.h"
#import "AFNetworking.h"
#import <objc/Ice/Initialize.h>
#import <objc/Glacier2.h>
#import <objc/Ice/LocalException.h>
#import <objc/Ice/Connection.h>

#define idleTimeOut 20


@interface IceMobileKit()
@end

@interface MyICEConnectionCallback : NSObject <ICEConnectionCallback>

@end

@implementation MyICEConnectionCallback

-(void) heartbeat:(id<ICEConnection>)con{
}
-(void) closed:(id<ICEConnection>)con{
    [CommunityIceMobileKit disConnect];
}

@end

static id<ICECommunicator> communicator;
static id<GLACIER2RouterPrx> router;
static id<GLACIER2SessionPrx> session;
static NSMutableDictionary * cls2PrxMap;
static id<LogDelegate> _logDelegate;
static id<ICEConnectionCallback> connectionCallback;

@implementation IceMobileKit

/**
 *  连接服务器
 */
+(void) setLogDelegate:(id<LogDelegate>)logDelegate {
    _logDelegate = logDelegate;
}
/**
 *  是否与服务器保持连接
 *
 *  @return 返回结果
 */
+(BOOL) isConnect {
    if (session == nil || ![session ice_isConnectionCached]) {
        if (cls2PrxMap != nil) {
            [cls2PrxMap removeAllObjects];
            cls2PrxMap = nil;
        }
        return NO;
    }
    return YES;
}

/**
 *  关闭连接
 */
+(void) disConnect {
    if (cls2PrxMap != nil) {
        [cls2PrxMap removeAllObjects];
        cls2PrxMap = nil;
    }
    if (session != nil && [session ice_isConnectionCached]) {
        [session destroy];
        session = nil;
        router = nil;
        communicator = nil;
    }
}

+(BOOL) connect {
    if (cls2PrxMap == nil) {
        cls2PrxMap = [NSMutableDictionary dictionaryWithCapacity:13];
    } else {
        [cls2PrxMap removeAllObjects];
    }
    //设置ICE属性
    ICEInitializationData* initData = [ICEInitializationData initializationData];
    initData.properties = [ICEUtil createProperties];
    [initData.properties setProperty:@"Ice.Default.Router" value:Glacier2Router];
    [initData.properties setProperty:@"Ice.RetryIntervals" value:@"-1"];
    [initData.properties setProperty:@"Ice.Trace.Network" value:@"0"];
    [initData.properties setProperty:@"Ice.IPv6" value:@"1"];
    if(USE_SECURE){
        NSString * dir = [[NSBundle mainBundle] pathForResource:@"ca" ofType:@"cer"];
        NSRange range = [dir rangeOfString:@"/" options:NSBackwardsSearch];
        if (range.location != NSNotFound){
            dir = [dir substringToIndex:range.location];
        }
        [initData.properties setProperty:@"Ice.Plugin.IceSSL" value:@"IceSSL:createIceSSL"];
        [initData.properties setProperty:@"IceSSL.Trace.Security" value:@"1"];
        [initData.properties setProperty:@"IceSSL.VerifyPeer" value:@"2"];
        [initData.properties setProperty:@"IceSSL.DefaultDir" value:"./"];
        [initData.properties setProperty:@"IceSSL.CheckCertName" value:@"0"];
        [initData.properties setProperty:@"IceSSL.CAs" value:@"ca.cer"];
        [initData.properties setProperty:@"IceSSL.CertFile" value:@"client.p12"];
        [initData.properties setProperty:@"IceSSL.Password" value:iceSSLPsw];
        [initData.properties setProperty:@"IceSSL.Keychain" value:@"client.keychain"];
        [initData.properties setProperty:@"IceSSL.KeychainPassword" value:iceSSLPsw];
    }
    communicator = [ICEUtil createCommunicator:initData];
    @try {
        router = [GLACIER2RouterPrx checkedCast:[communicator getDefaultRouter]];
        if(USE_SECURE){
            id<ICEAsyncResult> asyncResult = [router begin_createSessionFromSecureConnection];
//            session = [router createSessionFromSecureConnection];
            [asyncResult waitForSent];
            [asyncResult waitForCompleted];
            if([asyncResult isCompleted]){
                session = [router end_createSessionFromSecureConnection:asyncResult];
            }
        }else{
            session = [router createSession:userName password:userPsw];
        }
        if(session != nil){
            ICEInt acmTimeout = [router getACMTimeout];
            if(acmTimeout > 0){
                id<ICEConnection> conn = [router ice_getCachedConnection];
                [[conn getACM]setTimeout:(acmTimeout-2)];
                [[conn getACM]setClose:ICECloseOff];
                [[conn getACM]setHeartbeat:ICEHeartbeatAlways];
                
                connectionCallback = [[MyICEConnectionCallback alloc]init];
                
                [conn setCallback:connectionCallback];
            }
            return [session ice_isConnectionCached];
        }
        return NO;
    } @catch(NSException* ex){
        if(_logDelegate!=nil){
            [_logDelegate error:[ex description]];
        }else{
            SHLog(@"%@", [ex description]);
        }
        return false;
    }
}

/**
 *  获取服务代理
 *
 *  @param serviceCls 服务代理类
 *  @param block      回调块
 */

+(id<ICEObjectPrx>) getObjectPrx:(Class)serviceCls {
    if (![CommunityIceMobileKit isConnect]) {
        if([CommunityIceMobileKit connect]){
            if(_logDelegate != nil){
                [_logDelegate info:@"connect server"];
            }
        }else{
            if(_logDelegate != nil){
                [_logDelegate error:@"disconnect server"];
            }
            return nil;
        }
    }
    
    NSString * className = [NSString stringWithUTF8String:object_getClassName(serviceCls)];
    long pos = [className rangeOfString:@"Prx"].location;
    if (pos == NSNotFound) {
        NSString * err = @"Invalid ObjectPrx class ,class name must end with Prx";
        if (_logDelegate!=nil) {
            [_logDelegate error:err];
        }else{
            SHLog(@"%@", err);
        }
        return nil;
    } else {
        @try {
            NSString * serviceName = className;
            id<ICEObjectPrx> objectPrx = [cls2PrxMap objectForKey:serviceName];
            if(objectPrx == nil){
                ICEObjectPrx* base = [communicator stringToProxy:serviceName];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                objectPrx = [serviceCls performSelector:NSSelectorFromString(@"checkedCast:") withObject:base];
#pragma clang diagnostic pop
                
                if(objectPrx != nil){
                    [cls2PrxMap setObject:objectPrx forKey:serviceName];
                }
            }
            return objectPrx;
        } @catch(NSException* ex){
            if(_logDelegate!=nil){
                [_logDelegate error:[ex description]];
            }else{
                SHLog(@"%@", [ex description]);
            }
            return nil;
        }
    }
}

/**
 *  获取服务代理
 *
 *  @param serviceCls 服务代理类
 *  @param callback   获取后回调委托
 */
+(void) getObjectPrx:(Class)serviceCls callbackDelegate:(id<CallbackDelegate>)callbackDelegate faileCallbackDelegate:(id<FaileCallbackDelegate>)faileCallbackDelegate{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        id<ICEObjectPrx> objectPrx = [CommunityIceMobileKit getObjectPrx:serviceCls];
        dispatch_async(dispatch_get_main_queue(), ^ {
            if(objectPrx !=nil){
                [callbackDelegate callback:objectPrx errorMsg:nil];
            }else{
                if (faileCallbackDelegate != nil) {
                    [faileCallbackDelegate faileCallback];
                }
            }
        });
    });
}
/**
 *  获取服务代理
 *
 *  @param serviceCls 服务代理类
 *  @param block      回调块
 */
+(void) getObjectPrx:(Class)serviceCls block:(void(^)(id<ICEObjectPrx> proxy,NSString * errorMsg))block faileBlockFunction:(void(^)())faileBlockFunction{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        id<ICEObjectPrx> objectPrx = [CommunityIceMobileKit getObjectPrx:serviceCls];
        dispatch_async(dispatch_get_main_queue(), ^ {
            if(objectPrx !=nil){
                block(objectPrx,nil);
            }else{
                if (faileBlockFunction != nil) {
                    faileBlockFunction();
                }
            }
        });
    });
}

@end
