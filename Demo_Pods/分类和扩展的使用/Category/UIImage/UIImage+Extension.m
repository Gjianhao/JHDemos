//
//  UIImage+Extension.m
//  Demo_Pods
//
//  Created by gjh on 2021/1/23.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (UIImage *)imageWithCornerRadius:(CGFloat)radius ofSize:(CGSize)size {
    // 先将图片裁剪为目标比例,不拉伸压缩
    UIImage *originImage = [self scaleImage:size];
    // 当前 image 的可见绘制区域
    CGRect rect = (CGRect){0.f, 0.f, size};
    // 创建基于位图的上下文
    // [上下文大小, 是否是不透明的, 屏幕的分辨率]
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    // 在当前位图上下文添加圆角绘制路径 [上下文, 绘制圆形]
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    // 当前绘制路径和原绘制路径相交得到最终裁剪绘制路径
    CGContextClip(context);
    // 绘制
    [originImage drawInRect:rect];
    // 取得裁剪后的 image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭当前位图上下文
    UIGraphicsEndImageContext();
    return image;
}

/// 实现了UIViewContentModeScaleAspectFill效果,如果在外面设置 image.contentMode ,是没有效果的
/// @param newSize newSize
- (UIImage *)scaleImage:(CGSize)newSize {
    // 拿到图片的宽和高
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    
    // 实际要显示的比例
    CGFloat scale = newSize.width / newSize.height;
    // 图片的原始比例
    CGFloat imageScale = width / height;
    
    if (imageScale > scale) {
        // 以高为准
        width = height * scale;
    } else if (scale > imageScale) {
        // 以宽为准
        height = width * scale;
    } else {
        // 正常比例
    }
    // 中心放大
    CGRect frame = CGRectMake((self.size.width - width) / 2, (self.size.height - height) / 2, width, height);
    
    CGImageRef imageRef = [self CGImage];
    imageRef = CGImageCreateWithImageInRect(imageRef, frame);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    return image;
}

@end
