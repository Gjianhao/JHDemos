//
//  JHSDKManager.m
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/1.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHSDKManager.h"

@implementation JHSDKManager

+ (JHSDKManager *)sharedInstance {
    static JHSDKManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JHSDKManager alloc] init];
    });
    return manager;
}

- (void)launchInWindow:(UIWindow *)window {
    // 友盟统计
    
    
    // 日志
    // 这个类提供了一个用于终端输出或Xcode控制台输出的记录器，这取决于您运行代码的位置
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    // 这个类为苹果系统日志工具提供了一个记录器
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    // 要保存在磁盘上的归档日志文件的最大数量
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
}

@end
