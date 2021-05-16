//
//  JHTimer.m
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/5/16.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHTimer.h"

@implementation JHTimer {
    BOOL _valid;
    NSTimeInterval _timerInterval;
    BOOL _repeats;
    __weak id _target;
    SEL _selector;
    dispatch_source_t _source;
    dispatch_semaphore_t _lock;
}

+ (JHTimer *)timerWithTimerInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector repeats:(BOOL)repeats {
    return [[self alloc] initWithFireTimer:interval interval:interval target:target selector:selector repeats:repeats];
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"YYTimer init error" reason:@"Use the designated initializer to init." userInfo:nil];
    return [self initWithFireTimer:0 interval:0 target:self selector:@selector(<#selector#>) repeats:NO];
}

- (instancetype)initWithFireTimer:(NSTimeInterval)start interval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector repeats:(BOOL)repeats {
    self = [super init];
    _repeats = repeats;
}

@end
