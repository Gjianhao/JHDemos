//
//  JHIndexedTableView.m
//  Demo_Pods
//
//  Created by gjh on 2021/3/13.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHIndexedTableView.h"
#import "JHViewReusePool.h"

@interface JHIndexedTableView () {
    UIView *containerView;
    JHViewReusePool *reusePool;
}

@end
@implementation JHIndexedTableView

- (void)reloadData {
    [super reloadData];
    
    if (!containerView) {
        containerView = [[UIView alloc] initWithFrame:CGRectZero];
        containerView.backgroundColor = [UIColor whiteColor];
        
        // 避免索引条随着 tableview 滚动
        [self.superview insertSubview:containerView aboveSubview:self];
    }
    
    if (!reusePool) {
        reusePool = [[JHViewReusePool alloc] init];
    }
    
    // 标记所有视图为可重用状态
    [reusePool reset];
    // reload 字母索引条
    [self reloadIndexedBar];
}

- (void)reloadIndexedBar {
    // 获取字母索引条的显示内容
    NSArray<NSString *> *arrayTitles = nil;
    if ([self.indexedDataSource respondsToSelector:@selector(indexTitlesForIndexTableView:)]) {
        arrayTitles = [self.indexedDataSource indexTitlesForIndexTableView:self];
    }
    
    // 如果是空的就隐藏
    if (!arrayTitles || arrayTitles.count <= 0) {
        containerView.hidden = YES;
        return;
    }
    
    // 得到数量和宽高
    NSUInteger count = arrayTitles.count;
    CGFloat btnWidth = 60;
    
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    // 1、判断自己能否接收事件
    if (!self.userInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    // 2、判断点是否在自己身上
    if ([self pointInside:point withEvent:event]) {
        // 3、在自己身上，就遍历自己的子控件进行判断
        __block UIView *hit = nil;
        [self.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 坐标转换
            CGPoint convertPoint = [self convertPoint:point toView:obj];
            // 继续判断是否在子视图上面，在子视图上面，就可以返回 view，并且终止搜索
            hit = [obj hitTest:convertPoint withEvent:event];
            if (hit) {
                *stop = YES;
            }
        }];
        return hit ? hit : self;
    } else {
        return nil;
    }
}
/// 如果要改写点击视图的位置，就重写这个方法有效点击位置
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return YES;
}
@end
