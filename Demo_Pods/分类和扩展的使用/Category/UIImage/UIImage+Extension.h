//
//  UIImage+Extension.h
//  Demo_Pods
//
//  Created by gjh on 2021/1/23.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Extension)

/// 当前屏渲染,绘制UIImage矩形圆角
/// @param radius 半径
/// @param size 当前 image 的可见绘制区域
- (UIImage *)imageWithCornerRadius:(CGFloat)radius ofSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
