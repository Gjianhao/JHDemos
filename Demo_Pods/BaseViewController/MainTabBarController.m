//
//  MainTabBarController.m
//  Demo_Pods
//
//  Created by gjh on 2020/10/24.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "MainTabBarController.h"
#import "MineViewController.h"
#import "VideoViewController.h"
#import "NewsViewController.h"
#import "RecommendViewController.h"
#import "LoginViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    VideoViewController *videoVc = [[VideoViewController alloc] init];
    NewsViewController *newsVc = [[NewsViewController alloc] init];
    RecommendViewController *recommendVC = [[RecommendViewController alloc] init];
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self setViewControllers:@[newsVc, videoVc, recommendVC, mineVC, loginVC]];

}


@end
