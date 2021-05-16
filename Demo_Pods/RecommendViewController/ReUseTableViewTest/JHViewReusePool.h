//
//  JHViewReusePool.h
//  Demo_Pods
//
//  Created by gjh on 2021/3/13.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
/// 实现重用机制的类
@interface JHViewReusePool : NSObject

/// 从重用池中取出一个可重用的 view
- (UIView *)dequeueReusableView;

/// 向重用池中添加一个视图
- (void)addUsingView:(UIView *)view;

/// 重用方法，将当前使用中的视图移动到可重用队列当中
- (void)reset;

@end

NS_ASSUME_NONNULL_END
