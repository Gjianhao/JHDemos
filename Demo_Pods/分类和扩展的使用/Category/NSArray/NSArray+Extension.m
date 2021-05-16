//
//  NSArray+Extension.m
//  Demo_Pods
//
//  Created by gjh on 2021/1/11.
//  Copyright © 2021 gjh. All rights reserved.
//

@implementation NSArray (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = NSClassFromString(@"__NSArrayI");
        // 获取两个实例方法
        Method originMethod = class_getInstanceMethod(class, @selector(addObject:));
        Method swizzledMethod = class_getInstanceMethod(class, @selector(jh_addObject:));
        
        BOOL didAddMethod = class_addMethod(class, @selector(addObject:), method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class, @selector(jh_addObject:), method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        } else {
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)jh_addObject:(id)anObject {
    if (anObject != nil) {
        [self jh_addObject:anObject];
    }
}

@end
