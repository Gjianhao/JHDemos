//
//  JHLaunchManager.m
//  Demo_Pods
//
//  Created by gjh on 2021/3/20.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHLaunchManager.h"
#import "JHLaunchManager+UserData.h"
#import "JHUserManager.h"

#import "JHAccountViewController.h"

@interface JHLaunchManager ()

@property (nonatomic, weak) UIWindow *window;

@property (nonatomic, strong, readwrite) TLTabBarController *tabBarController;

@property (nonatomic, strong, readwrite) __kindof UIViewController *curRootVC;

@end

@implementation JHLaunchManager

+ (JHLaunchManager *)sharedInstance {
    static JHLaunchManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JHLaunchManager alloc] init];
    });
    return instance;
}

- (void)launchInWindow:(UIWindow *)window {
    self.window = window;
    
    // 状态栏高亮
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if ([JHUserManager sharedInstance].isLogin) {
        // 添加底部的tabbar控制器组
        [self.tabBarController setViewControllers:[self _createTabBarChildViewController]];
        [self setCurRootVC:self.tabBarController];
        
        // 初始化用户信息
        [self initUserData];
    } else {
        // 未登录
        JHAccountViewController *accountVC = [[JHAccountViewController alloc] init];
        TLWeakSelf(self);
        [accountVC setLoginSuccess:^{
            TLStrongSelf(weakself);
            [strongweakself launchInWindow:window];
        }];
        
        [self setCurRootVC:accountVC];
    }
}

- (void)setCurRootVC:(__kindof UIViewController *)curRootVC {
    _curRootVC = curRootVC;
    
    UIWindow *window = self.window ? self.window : [UIApplication sharedApplication].keyWindow;
    [window removeAllSubviews];
    [window setRootViewController:curRootVC];
    [window addSubview:curRootVC.view];
    [window makeKeyAndVisible];
}

#pragma mark - 私有方法
- (NSArray *)_createTabBarChildViewController {
//    MineViewController *mineVC = [[MineViewController alloc] init];
//    VideoViewController *videoVc = [[VideoViewController alloc] init];
//    NewsViewController *newsVc = [[NewsViewController alloc] init];
//    RecommendViewController *recommendVC = [[RecommendViewController alloc] init];
//    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    NSArray *data = @[
//        addNavigationController(mineVC),
//        addNavigationController(videoVc),
//        addNavigationController(newsVc),
//        addNavigationController(recommendVC),
//        addNavigationController(loginVC)
//    ];
//    return data;
    return nil;
}

#pragma mark - Getters

- (TLTabBarController *)tabBarController {
    if (!_tabBarController) {
        TLTabBarController *tabBarVC = [[TLTabBarController alloc] init];
        [tabBarVC.tabBar setBackgroundColor:[UIColor colorGrayBG]];
        [tabBarVC.tabBar setTintColor:[UIColor colorGreenDefault]];
        _tabBarController = tabBarVC;
    }
    return _tabBarController;
}
@end
