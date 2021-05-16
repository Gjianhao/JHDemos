//
//  JHViewController.h
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/8.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHViewController : UIViewController

@property (nonatomic, strong) NSString *analyzeTitle;

/// 当前VC statusBar 的状态，仅在viewWillAppear时生效，默认LightContent
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;

@end

NS_ASSUME_NONNULL_END
