//
//  ViewController+Swizzling.m
//  Demo_Pods
//
//  Created by gjh on 2020/10/13.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "ViewController+Swizzling.h"
#import <objc/runtime.h>

@implementation ViewController (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        // 原方法名和替换方法名
        SEL originalSelector = @selector(originalFunction);
        SEL swizzledSelector = @selector(swizzledFunction);
        
        // 两个方法结构体
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        // 向具有给定名称和实现的类添加新方法。
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}

- (void)originalFunction {
    NSLog(@"%s", __func__);
}
- (void)swizzledFunction {
    NSLog(@"%s", __func__);
}

@end
