//
//  JHScreen.h
//  Demo_Pods
//
//  Created by gjh on 2020/11/15.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLShortcutMacros.h"

NS_ASSUME_NONNULL_BEGIN


#define UI(x) UIAdapter(x)
#define UIRect(x, y, width, height) UIRectAdapter(x, y, width, height)

#define IPHONE_X_XR_XMAX (IPHONE_X || IPHONE_XR || IPHONE_XS_MAX)

#define IPHONE_X (SCREEN_WIDTH == [JHScreen sizeFor58Inch].width && SCREEN_HEIGHT == [JHScreen sizeFor58Inch].height)
#define IPHONE_XR (SCREEN_WIDTH == [JHScreen sizeFor61Inch].width && SCREEN_HEIGHT == [JHScreen sizeFor61Inch].height && [UIScreen mainScreen].scale == 2)
#define IPHONE_XS_MAX (SCREEN_WIDTH == [JHScreen sizeFor65Inch].width && SCREEN_HEIGHT == [JHScreen sizeFor65Inch].height && [UIScreen mainScreen].scale == 3)

#define STATUSBARHEIGHT (IPHONE_X_XR_XMAX ? 44 : 20)


/// 还可以再传一个参数，表示机型不同
/// @param x 值
static inline NSInteger UIAdapter (float x) {
    // 分机型 特定的比例
    
    // 屏幕宽度按比例适配(以iPhone 6Plus的大小作为基准)
    CGFloat scale = 414/SCREEN_WIDTH;
    return (NSInteger)x/scale;
}

static inline CGRect UIRectAdapter (x, y, width, height) {
    return CGRectMake(UIAdapter(x), UIAdapter(y), UIAdapter(width), UIAdapter(height));
}

@interface JHScreen : NSObject

/// iPhone XS Max
+ (CGSize)sizeFor65Inch;

/// iPhone XR
+ (CGSize)sizeFor61Inch;

/// iPhoneX
+ (CGSize)sizeFor58Inch;

@end

NS_ASSUME_NONNULL_END
