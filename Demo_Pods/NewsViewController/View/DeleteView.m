//
//  DeleteView.m
//  Demo_Pods
//
//  Created by gjh on 2020/10/26.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "DeleteView.h"

@interface DeleteView ()

@property (nonatomic, strong, readwrite) UIView *backGroundView;

@property (nonatomic, strong, readwrite) UIButton *deletebtn;

@property (nonatomic, copy, readwrite) dispatch_block_t clickBlock;

@end

@implementation DeleteView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _backGroundView = [[UIView alloc] initWithFrame:self.bounds];
            _backGroundView.backgroundColor = [UIColor blackColor];
            _backGroundView.alpha = 0.5;
            [_backGroundView addGestureRecognizer:({
                UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDeleteBtnView)];
                gesture;
            })];
            _backGroundView;
        })];
        [self addSubview:({
            _deletebtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
            [_deletebtn addTarget:self action:@selector(deletebtnEvent) forControlEvents:UIControlEventTouchUpInside];
            [_deletebtn setBackgroundColor:[UIColor blueColor]];
            _deletebtn;
        })];
    }
    return self;
}

- (void)showDeleteBtnViewFromPoint:(CGPoint)point clickBolck:(dispatch_block_t)clickBlock {
    [_deletebtn setFrame:CGRectMake(point.x, point.y, 200, 200)];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _clickBlock = [clickBlock copy];
//    [UIView animateWithDuration:1.f animations:^{
//        [self.deletebtn setFrame:CGRectMake((ScreenWidth-200)/2, (ScreenHeight-200)/2, 200, 200)];
//    }];

    [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.deletebtn setFrame:CGRectMake((SCREEN_WIDTH - 200) / 2, (SCREEN_HEIGHT - 200) / 2, 200, 200)];
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.deletebtn.center = CGPointMake(200, 200);
    } completion:^(BOOL finished) {
        // 完成回调
    }];
}

- (void)dismissDeleteBtnView {
    [self removeFromSuperview];
}

- (void)deletebtnEvent {
    if (_clickBlock) {
        _clickBlock();
    }
    [self removeFromSuperview];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 1.判断下自己能否接收事件
    if (self.userInteractionEnabled == NO ||
        self.hidden == YES ||
        self.alpha <= 0.01) {
        return nil;
    }
    // 2.判断下点在不在当前控件上
    if ([self pointInside:point withEvent:event] == NO) {
        return nil;
    }
    // 3.从后往前遍历自己的子控件
    int count = (int)self.subviews.count;
    for (int i = count - 1; i >= 0; i--) {
        // 获取子控件
        UIView *chileView = self.subviews[i];
        // 转换坐标系,把当前坐标系上的点转换成子控件上的点
        CGPoint childPoint = [self convertPoint:point toView:chileView];
        UIView *fitView = [chileView hitTest:childPoint withEvent:event];
        if (fitView) {
            return fitView;
        }
    }
    // 4.如果没有比自己合适的子控件,最合适的view 还是自己
    return self;
}
@end
