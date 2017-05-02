//
//  IceMobileKit.h
//  IceMobileKit
//
//  Created by 邓燎燕 on 16/3/17.
//  Copyright © 2016年 邓燎燕. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * IS_TEST ＝ 0，使用SSL连接
 * IS_TEST ＝ 1，使用TCP连接
 */
#define IS_TEST 0

#if IS_TEST == 0
#define Glacier2Router @"DemoGlacier2/router:ssl -p 4063 -h 192.168.0.112 -t 10000"
#define USE_SECURE YES
#else
#define Glacier2Router @"Glacier2/router:tcp -p 6063 -h 10.0.0.111 -t 10000"
#define USE_SECURE NO
#endif

#define iceSSLPsw @"123456"
#define userName @"dly"
#define userPsw @"123456"

@protocol ICEObjectPrx;

/**
 失败回调
 */
@protocol FaileCallbackDelegate <NSObject>

/**
 *  回调
 */
-(void)faileCallback;

@end
/**
 *  回调委托
 */
@protocol CallbackDelegate <NSObject>
@optional
/**
 *  回调
 *
 *  @param proxy    服务代理
 *  @param errorMsg 错误信息，如果为nil表示没有错误，如果不为nil表示有错误
 */
-(void)callback:(id<ICEObjectPrx>)proxy errorMsg:(NSString*)errorMsg;

@end

/**
 *  日志委托
 */
@protocol LogDelegate <NSObject>
@optional
/**
 *  一般日志回调
 *
 *  @param msg    日志信息
 */
-(void)info:(NSString*)msg;
/**
 *  错误日子回调
 *
 *  @param msg    日志信息
 */
-(void)error:(NSString*)msg;

@end

/**
 *  智之屋移动端ICE服务统一调用入口
 */
@interface CommunityIceMobileKit : NSObject

/**
 *  连接服务器
 */
+(void) setLogDelegate:(id<LogDelegate>)logDelegate;
/**
 *  是否与服务器保持连接
 *
 *  @return 返回结果
 */
+(BOOL) isConnect;
/**
 *  获取服务代理
 *
 *  @param serviceCls 服务代理类
 *  @param callback   获取后回调委托
 */
+(void) getObjectPrx:(Class)serviceCls callbackDelegate:(id<CallbackDelegate>)callbackDelegate faileCallbackDelegate:(id<FaileCallbackDelegate>)faileCallbackDelegate;
/**
 *  获取服务代理
 *
 *  @param serviceCls 服务代理类
 *  @param block      回调块
 */
+(void) getObjectPrx:(Class)serviceCls block:(void(^)(id<ICEObjectPrx> proxy,NSString * errorMsg))block faileBlockFunction:(void(^)())faileBlockFunction;
/**
 *  关闭连接
 */
+(void) disConnect;

@end
