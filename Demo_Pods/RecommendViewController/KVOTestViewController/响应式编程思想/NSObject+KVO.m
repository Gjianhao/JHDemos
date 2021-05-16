//
//  NSObject+KVO.m
//  Demo_Pods
//
//  Created by gjh on 2020/12/4.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "NSObject+KVO.h"
#import <objc/message.h>
#import "JHKVONotifying_Person.h"

NSString *const observerKey = @"observer";

@interface NSObject (KVO)

@property (nonatomic, strong) NSString *address;

@end

@implementation NSObject (KVO)

/// 添加关联对象
- (void)setAddress:(NSString *)address {
    objc_setAssociatedObject(self, "address", address, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)address {
    return objc_getAssociatedObject(self, "address");
}


- (void)jh_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
    // 把观察者保存到当前对象
    // 关联对象
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(observerKey), observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 更换对象的isa指针，
    object_setClass(self, [JHKVONotifying_Person class]);
}

@end
