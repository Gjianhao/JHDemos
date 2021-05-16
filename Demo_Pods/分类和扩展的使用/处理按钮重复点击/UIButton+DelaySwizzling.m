////
////  UIButton+DelaySwizzling.m
////  Demo_Pods
////
////  Created by gjh on 2020/10/18.
////  Copyright © 2020 gjh. All rights reserved.
////
//
//#import "UIButton+DelaySwizzling.h"
//#import <objc/runtime.h>
//
//@interface UIButton ()
//
//@property (nonatomic, assign) NSTimeInterval new_acceptEventInterval;
//@property (nonatomic, assign) NSTimeInterval new_acceptEventTime;
//
//@end
//
//@implementation UIButton (DelaySwizzling)
//
//+ (void)load {
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        
//        Method originalMethod = class_getInstanceMethod(class, @selector(sendAction:to:forEvent:));
//        Method swizzledMethod = class_getInstanceMethod(class, @selector(new_sendAction:to:forEvent:));
//        
//        BOOL didAddMethod = class_addMethod(class, @selector(sendAction:to:forEvent:), method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
//        
//        if (didAddMethod) {
//            class_replaceMethod(class, @selector(new_sendAction:to:forEvent:), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//    
//}
//
//- (void)new_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
//    
//    /**
//     统一时间间隔
//     */
//    if (self.new_acceptEventInterval <= 0) {
//        // 如果没有自定义时间间隔，设置为 0.4 秒
//        self.new_acceptEventInterval = 0.4;
//    }
//    
//    // 是否小于设定的时间间隔
//    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.new_acceptEventTime >= self.new_acceptEventInterval);
//        
//    // 更新上一次点击时间戳
//    if (self.new_acceptEventInterval > 0) {
//        self.new_acceptEventTime = NSDate.date.timeIntervalSince1970;
//    }
//    
//    // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
//    if (needSendAction) {
//        [self new_sendAction:action to:target forEvent:event];
//    }
//}
//
//- (NSTimeInterval )new_acceptEventInterval{
//    return [objc_getAssociatedObject(self, "UIControl_acceptEventInterval") doubleValue];
//}
//
//- (void)setNew_acceptEventInterval:(NSTimeInterval)xxx_acceptEventInterval{
//    objc_setAssociatedObject(self, "UIControl_acceptEventInterval", @(xxx_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (NSTimeInterval )new_acceptEventTime{
//    return [objc_getAssociatedObject(self, "UIControl_acceptEventTime") doubleValue];
//}
//
//- (void)setNew_acceptEventTime:(NSTimeInterval)xxx_acceptEventTime{
//    objc_setAssociatedObject(self, "UIControl_acceptEventTime", @(xxx_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//@end
