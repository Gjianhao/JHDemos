//
//  JHCoreAnimationViewController.m
//  Demo_Pods
//
//  Created by gjh on 2021/2/19.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHCoreAnimationViewController.h"

#define angleToRadians(angle) ((angle)/180.0 * M_PI)
@interface JHCoreAnimationViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) CALayer *redLayer;

@end

@implementation JHCoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
    _redLayer = [CALayer layer];
    _redLayer.frame = CGRectMake(100, 100, 50, 50);
    _redLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:_redLayer];
    
}
// 贝塞尔曲线
- (void)test {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, 200)]; // 起点
    [path addCurveToPoint:CGPointMake(300, 200) controlPoint1:CGPointMake(100, 100) controlPoint2:CGPointMake(200, 300)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = nil;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];
    
    // 添加小车
    CALayer *carlayer = [CALayer layer];
    carlayer.frame = CGRectMake(15, 200-18, 36, 36);
    carlayer.backgroundColor = [UIColor blueColor].CGColor;
    carlayer.cornerRadius = 18;// 设置成圆形
    // 设置锚点， 让这个圆形在弧线上滚动, 锚点就是中心点的单位坐标，默认是（0.5，0.5）
    carlayer.anchorPoint = CGPointMake(0.5, 1);
    [self.view.layer addSublayer:carlayer];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"position";
    anim.path = path.CGPath;
    anim.duration = 4.0;
    anim.rotationMode = kCAAnimationRotateAuto; // 自动转向
    [carlayer addAnimation:anim forKey:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint p = [[touches anyObject] locationInView:self.view];
    if ([_redLayer.presentationLayer hitTest:p]) {
        NSLog(@"1");
    }
    // 窗口抖动动画（关键帧动画）
    CAKeyframeAnimation *frameAnim = [CAKeyframeAnimation animation];
    frameAnim.keyPath = @"transform.rotation"; // 旋转角度
    frameAnim.values = @[@angleToRadians(-3), @angleToRadians(3)]; // 角度转弧度，再填一个到-3 的角度就好看了, @angleToRadians(-3)，或者设置autoreverse 属性为yes；
    frameAnim.autoreverses = YES; // 但是速度变慢了， 再设置一个速度 speed 为 2
    frameAnim.speed = 2;
    frameAnim.repeatCount = MAXFLOAT;
    [_redLayer addAnimation:frameAnim forKey:nil];
    //*
     // 只写这一句就是隐式动画，下面就是显式动画
     _redLayer.frame = CGRectMake(100, 400, 100, 100); // 设置图层动画的最终位置
     CABasicAnimation *anim = [CABasicAnimation animation];
     anim.keyPath = @"position.y";
     // 应该不设置这个值，而是先设置 frame 就是最后要到的位置
 //    anim.toValue = @400;
     anim.duration = 1;
     anim.delegate = self; // 注意这个代理是唯一的强引用属性
     // 完成后会回到原处，设置完成时不移除动画  但是下面这两个设置是不正确的（官方说的）
 //    anim.removedOnCompletion = NO;
 //    anim.fillMode = kCAFillModeForwards;// 当动画完成时，接收器在其最终状态下仍然可见。
     [_redLayer addAnimation:anim forKey:nil];
        //*/
    
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"初始位置：%@", NSStringFromCGRect(_redLayer.frame));
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"结束位置：%@", NSStringFromCGRect(_redLayer.frame));
    NSLog(@"结束位置：%@", NSStringFromCGRect(_redLayer.presentationLayer.frame));// 当前在屏幕上显示的层状态，是可以显示位置改变后的位置
}
@end
