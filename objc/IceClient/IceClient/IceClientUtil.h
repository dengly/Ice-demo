//
//  IceClientUtil.h
//  test
//
//  Created by 邓燎燕 on 15/12/8.
//  Copyright © 2015年 邓燎燕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/Ice.h>

@protocol ICECommunicator;

typedef void (^dispatch_block)(void);

@interface IceClientUtil : NSObject
/**
 *  获取Ice连接器
 *
 *  @return id<ICECommunicator>
 */
+ (id<ICECommunicator>) getICECommunicator;
/**
 *  关闭Ice连接器
 *
 *  @param removeServiceCache 是否清楚缓存
 */
+ (void) closeCommunicator:(BOOL)removeServiceCache;
/**
 *  获取代理服务对象
 *
 *  @param serviceName 服务名称
 *  @param serviceCls  服务类型
 *
 *  @return id<ICEObjectPrx>
 */
+ (id<ICEObjectPrx>) getServicePrx:(NSString*)serviceName class:(Class)serviceCls ;
/**
 *  异步执行服务
 *
 *  @param block 执行服务块
 */
+ (void)serviceAsync:(dispatch_block)block;

@end
