//
//  JHLineView.m
//  Demo_Pods
//
//  Created by gjh on 2021/1/21.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHLineView.h"

@implementation JHLineView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
////    [self drawLine];
////    [self drawRectangle];
////    [self drawTriangle];
////    [self drawCircle];
//    [self drawSector];
//}
#pragma mark - 画扇型
- (void)drawSector {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextMoveToPoint(context, 100, 100);
    CGContextAddArc(context, 100, 100, 60, - M_PI_4, - 3 * M_PI_4, 1);
    CGContextClosePath(context);
    CGContextStrokePath(context);
}
#pragma mark - 画弧线
- (void)drawArc {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    // 上下文, 圆心 x, 圆心y, 半径, 起始点, 终点, 顺/逆时针
    CGContextAddArc(context, 100, 100, 60, 0, M_PI, 1);
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

#pragma mark - 画圆
- (void)drawCircle {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(10, 10, 100, 100));
    CGContextStrokePath(context);
}

#pragma mark - 画个三角形
- (void)drawTriangle {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextMoveToPoint(context, 10, 10);
    CGContextAddLineToPoint(context, 110, 10);
    CGContextAddLineToPoint(context, 110, 110);
    CGContextClosePath(context); // 封闭路径
    CGContextStrokePath(context);
}
#pragma mark - 画一个矩形
- (void)drawRectangle {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0, 1.0, 0, 1);
    // 设置线宽
    CGContextSetLineWidth(context, 5);
//    CGContextMoveToPoint(context, 10, 10); // 起始点
//    CGContextAddLineToPoint(context, 110, 10);
//    CGContextAddLineToPoint(context, 110, 110);
//    CGContextAddLineToPoint(context, 10, 110);
//    CGContextAddLineToPoint(context, 10, 10);
    // 方法二
    CGContextAddRect(context, CGRectMake(10, 10, 100, 100));
//    CGContextStrokePath(context); // 渲染  空心
    CGContextFillPath(context);  // 实心
}
#pragma mark - 画一条线
- (void)drawLine {
    // 绘制一条线
    // 获取上下文 上下文的输出目录就是 self view
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置线的颜色
    CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1);
    // 设置线宽
    CGContextSetLineWidth(context, 12.0);
    // 设置线的头尾的样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    // 设置线的链接点的样式
    CGContextSetLineJoin(context, kCGLineJoinRound);
    // 画一条线
    // 设置一个起点
    CGContextMoveToPoint(context, 10, 10);
    // 设置连线另一个点
    CGContextAddLineToPoint(context, 30, 100);
    CGContextAddLineToPoint(context, 110, 110);
    // 渲染 画到 view
    CGContextStrokePath(context);
}
@end
