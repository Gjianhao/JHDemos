//
//  JHMediator.h
//  Demo_Pods
//
//  Created by gjh on 2020/11/16.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^JHMediatorProcressBlock)(NSDictionary *params);

@interface JHMediator : NSObject

/* target  Action */
+ (__kindof UIViewController *)detailControllerWithUrl:(NSString *)detailUrl;

/* urlscheme */
+ (void)registerScheme:(NSString *)scheme processBlock:(JHMediatorProcressBlock)block;
+ (void)openUrl:(NSString *)url params:(NSDictionary *)params;

/* protocol class */
+ (void)registerProtocol:(Protocol *)protocol cls:(Class)cls;
+ (Class)classForProtocol:(Protocol *)protocol;

@end

NS_ASSUME_NONNULL_END
