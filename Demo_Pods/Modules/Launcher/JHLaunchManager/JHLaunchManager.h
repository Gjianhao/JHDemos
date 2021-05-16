//
//  JHLaunchManager.h
//  Demo_Pods
//
//  Created by gjh on 2021/3/20.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TLTabBarController/TLTabBarController.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHLaunchManager : NSObject

// 当前根控制器
@property (nonatomic, strong, readonly) __kindof UIViewController *curRootVC;

// 根 tabBarController
@property (nonatomic, strong, readonly) TLTabBarController *tabBarController;

+ (JHLaunchManager *)sharedInstance;

/// 启动、初始化
/// @param window 窗口
- (void)launchInWindow:(UIWindow *)window;

@end

NS_ASSUME_NONNULL_END
