//
//  JHTimer.h
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/5/16.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHTimer : NSObject

+ (JHTimer *)timerWithTimerInterval:(NSTimeInterval)interval
                             target:(id)target
                           selector:(SEL)selector
                            repeats:(BOOL)repeats;

- (instancetype)initWithFireTimer:(NSTimeInterval)start
                         interval:(NSTimeInterval)interval
                           target:(id)target
                         selector:(SEL)selector
                          repeats:(BOOL)repeats NS_DESIGNATED_INITIALIZER;

@property (readonly) BOOL repeats;
@property (readonly) NSTimeInterval timeInterval;
@property (readonly, getter=isValid) BOOL valid;

- (void)invalidate;

- (void)fire;

@end

NS_ASSUME_NONNULL_END
