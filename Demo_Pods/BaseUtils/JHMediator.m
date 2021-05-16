//
//  JHMediator.m
//  Demo_Pods
//
//  Created by gjh on 2020/11/16.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "JHMediator.h"

@implementation JHMediator

+ (__kindof UIViewController *)detailControllerWithUrl:(NSString *)detailUrl {
    Class detailCls = NSClassFromString(@"DetailNewsViewController");
    UIViewController *VC = [[detailCls alloc] performSelector:NSSelectorFromString(@"initWithUrl:") withObject:detailUrl];
    return VC;
}

#pragma mark - urlscheme

+ (NSMutableDictionary *)mediatorCache {
    static NSMutableDictionary *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = @{}.mutableCopy;
    });
    return cache;
}

+ (void)registerScheme:(NSString *)scheme processBlock:(JHMediatorProcressBlock)block {
    if (scheme && block) {
        [[[self class] mediatorCache] setObject:block forKey:scheme];
    }
}

+ (void)openUrl:(NSString *)url params:(NSDictionary *)params {
    JHMediatorProcressBlock block = [[[self class] mediatorCache] objectForKey:url];
    if (block) {
        block(params);
    }
}

#pragma mark - protocol class

+ (void)registerProtocol:(Protocol *)protocol cls:(Class)cls {
    if (protocol && cls) {
        [[[self class] mediatorCache] setObject:cls forKey:NSStringFromProtocol(protocol)];
    }
}
 
+ (Class)classForProtocol:(Protocol *)protocol {
    return nil;
}
@end
