//
//  UIViewController+Swizzling.m
//  Demo_Pods
//
//  Created by gjh on 2020/10/14.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "UIViewController+Swizzling.h"
#import <objc/runtime.h>

@implementation UIViewController (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(new_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}


///
/// @param animated animated description
- (void)new_viewWillAppear:(BOOL)animated {
    if (![self isKindOfClass:[UIViewController class]]) {
        NSLog(@"进入界面%@", [self class]);
    }
    
    [self new_viewWillAppear:animated];
}

@end
