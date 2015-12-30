//
//  IceGlacier2Util.h
//  test
//
//  Created by 邓燎燕 on 15/12/21.
//  Copyright © 2015年 邓燎燕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/Ice.h>
#import <objc/Glacier2.h>

typedef void (^dispatch_block)(void);

@interface IceGlacier2Util : NSObject

+ (id<ICECommunicator>) getICECommunicator;
+ (void) closeCommunicator:(BOOL)removeServiceCache;

+ (void)serviceAsync:(dispatch_block)block;

+ (id<ICEObjectPrx>) getServicePrx:(NSString*)serviceName class:(Class)serviceCls;

@end
