//
//  JHCALayerTestViewController.m
//  Demo_Pods
//
//  Created by gjh on 2021/1/22.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHCALayerTestViewController.h"

@interface JHCALayerTestViewController ()

@end

@implementation JHCALayerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self CATextLayer];
//    [self CAShapeLayer];
//    [self CAGradientLayer];
}

- (void)UIBezierPath {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:100 startAngle:0 endAngle:M_PI_2 clockwise:YES];
    path.lineWidth = 5;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
}

#pragma mark - CAGradientLayer

/// 它是一个硬件加速的高性能绘制图层.主要用来实现多种颜色的平滑渐变效果,
/// 这里给出一个三种颜色从正方形左上角到右下角渐变效果实例代码
- (void)CAGradientLayer {
    // 创建layer 承载视图
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 150, 150)];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = backView.bounds; // view和 layer 重合
    // 依次设置渐变颜色数组
    gradientLayer.colors = @[(__bridge id)[UIColor greenColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor orangeColor].CGColor];
    // 颜色从起点到终点按比例分段位置
    gradientLayer.locations = @[@0, @.3, @0.5];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    [backView.layer addSublayer:gradientLayer];
    [self.view addSubview:backView];
}

#pragma mark - CAShapeLayer

/// 专门用来绘制矢量图形的图形子类,可以指定线宽和颜色等利用CGPath绘制图形路径,可以实现图形的3D变换效果,
/// 1.渲染效率比Core Graphics快很多,而且可以在超出视图边界之外绘制,不会被边界裁剪掉.
/// 2.内存使用更加高效,普通的 CALayer 对象要创建一个寄宿图,而 CAShaperLayer 不需要,这样就解约了内存.
/// 3.通常通过指定 CAShapeLayer对象的 path 属性来绘制图层.
- (void)CAShapeLayer {
    // 创建圆形的路径
    UIBezierPath *path = [[UIBezierPath alloc] init];
    // 起点要在圆心右侧水平半径处
    [path moveToPoint:CGPointMake(200, 200)];
    // 添加圆形弧路径
    [path addArcWithCenter:CGPointMake(150, 200) radius:50 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    // 创建图形的层
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    // 路径线的颜色
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    // 闭合图形(内部)填充颜色
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    // 线宽
    shapeLayer.lineWidth = 5;
    // 线的样式,端点,交点
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineJoin = kCALineJoinRound;
    // 设置图形的路径, 使用 UIBezierpath类帮助创建图层路径,这样就不需要人工释放 CGPath了.
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
}
#pragma mark - CATextLayer 案例

/// 实现更加灵活的文字布局和渲染,包括了UILable 几乎所有的功能
/// 渲染效率明显高于 UILabel
- (void)CATextLayer {
    /* 创建一个字符承载视图 */
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
    textView.backgroundColor = [UIColor yellowColor];
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = textView.frame;
//    NSLog(@"%@--%@--%@--%@", textView.frame, textView.bounds, textLayer.frame, textLayer.bounds);
    textLayer.string = @"CATextLayer";
    // 文字的前景色和背景色
    textLayer.foregroundColor = [UIColor whiteColor].CGColor; //用于渲染接收文本的颜色。
    textLayer.backgroundColor = [UIColor grayColor].CGColor;
    // 文字超出视图边界裁剪
    textLayer.wrapped = YES;
    // 文字的字体
    textLayer.font = (__bridge CFTypeRef _Nullable)([UIFont systemFontOfSize:30].fontName);
    // 文字居中
    textLayer.alignmentMode = kCAAlignmentCenter;
    // 适应屏幕的 Retina分辨率,防止像素画导致模糊
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [textView.layer addSublayer:textLayer];
    [self.view addSubview:textView];
}


@end
