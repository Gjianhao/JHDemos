//
//  JHLaunchManager+UserData.m
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/5.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHLaunchManager+UserData.h"

@implementation JHLaunchManager (UserData)

- (void)initUserData {
    NSNumber *lastRunDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastRunDate"];
    
    if (!lastRunDate) {
        [TLAlertView showWithTitle:@"提示" message:@"首次启动App，是否随机下载两组个性表情包，稍候也可在“我的”-“表情”中选择下载。" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] actionHandler:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                [self downloadDefaultExpression];
            }
        }];
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:lastRunDate.doubleValue];
    NSNumber *sponsorStatus = [[NSUserDefaults standardUserDefaults] objectForKey:@"sponsorStatus"];
    NSLog(@"今天第%ld次进入", sponsorStatus.integerValue);
    if ([date isSameDay:[NSDate date]]) {
        if (sponsorStatus.integerValue == 3) {
            [TLAlertView showWithTitle:@"提醒" message:@"看看人家的代码写的多好" cancelButtonTitle:@"取消" otherButtonTitles:@[@"努力"] actionHandler:^(NSInteger buttonIndex) {
                if (buttonIndex == 1) {
                    
                } else {
                    
                }
                [[NSUserDefaults standardUserDefaults] setObject:@(-1) forKey:@"sponsorStatus"];
            }];
        }
        [[NSUserDefaults standardUserDefaults] setObject:@(sponsorStatus.integerValue + 1) forKey:@"sponsorStatus"];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@([[NSDate date] timeIntervalSince1970]) forKey:@"lastRunDate"];
        if (sponsorStatus.integerValue != -1) {
            [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"sponsorStatus"];
        }
    }
}

/// 下载默认表情包
- (void)downloadDefaultExpression {
    [TLToast showLoading:nil];
    __block NSInteger count = 0;
    __block NSInteger successCount = 0;
    
}

@end
