//
//  JHViewController.m
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/8.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHViewController.h"

@interface JHViewController ()

@end

@implementation JHViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 统计页面显示时长
    [MobClick beginLogPageView:self.analyzeTitle];
    if ([UIApplication sharedApplication].statusBarStyle != self.statusBarStyle) {
        [UIApplication sharedApplication].statusBarStyle = self.statusBarStyle;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.analyzeTitle];
}

- (void)dealloc
{
#ifdef DEBUG_MEMERY
    NSLog(@"dealloc %@", self.navigationItem.title);
#endif
}

#pragma mark - Getter
- (NSString *)analyzeTitle {
    if (_analyzeTitle == nil) {
        return self.navigationItem.title;
    }
    return _analyzeTitle;
}

@end
