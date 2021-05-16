//
//  JHViewReusePool.m
//  Demo_Pods
//
//  Created by gjh on 2021/3/13.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHViewReusePool.h"

@interface JHViewReusePool ()

// 等待使用队列
@property (nonatomic, strong) NSMutableSet *waitUseQueue;

// 使用中队列
@property (nonatomic, strong) NSMutableSet *usingQueue;

@end

@implementation JHViewReusePool

- (instancetype)init
{
    self = [super init];
    if (self) {
        _waitUseQueue = [[NSMutableSet alloc] init];
        _usingQueue = [[NSMutableSet alloc] init];
    }
    return self;
}

- (UIView *)dequeueReusableView {
    // 从等待使用队列中取出一个 view
    UIView *view = [_waitUseQueue anyObject];
    if (view) {
        // 将 view 从等待队列中移除，添加到使用队列中
        [_waitUseQueue removeObject:view];
        [_usingQueue addObject:view];
        return view;
    } else {
        return nil;
    }
}

- (void)addUsingView:(UIView *)view {
    if (!view) {
        return;
    }
    
    [_usingQueue addObject:view];
}

- (void)reset {
    UIView *view = nil;
    while ((view = [_usingQueue anyObject])) {
        [_waitUseQueue addObject:view];
        [_usingQueue removeObject:view];
    }
}

@end
