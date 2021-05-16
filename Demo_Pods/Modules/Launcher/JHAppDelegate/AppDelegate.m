//
//  AppDelegate.m
//  Demo_Pods
//
//  Created by gjh on 2020/8/25.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "AppDelegate.h"
#import <execinfo.h>
#import "DBManager.h"
#import "JHLaunchManager.h"
#import "JHSDKManager.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate

/**
 进程开始启动
 */
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 初始化第三方SDK
    [[JHSDKManager sharedInstance] launchInWindow:self.window];
    // 初始化UI
    [[JHLaunchManager sharedInstance] launchInWindow:self.window];
    
//    MainTabBarController *mainvc = [[MainTabBarController alloc] init];
//    mainvc.delegate = self;
//    UINavigationController *navigationCon = [[UINavigationController alloc] initWithRootViewController:mainvc];
//    self.window.rootViewController = navigationCon;
//    [self.window makeKeyAndVisible];
//
//    // 创建数据库
//    [[DBManager sharedInstance] createDatabase];
    [self _caughtException];
    
    [self urgentMethod];
    
    return YES;    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // 应用程序将要退出前台，进入非活动状态，在此期间，应用程序不接收消息或者事件
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 应用程序已经进入前台，
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 开始在后台运行
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 即将进入前台
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // 当程序将要被终止时被调用
}

#pragma mark - 跳转打开本应用
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    
    return YES;
}

#pragma mark - crash

- (void)_caughtException {
    /* NSException */
    NSSetUncaughtExceptionHandler(HandlerNSException);
    
    /* 注册需要监听的信号量 signal */
    signal(SIGABRT, SignalExceptionHandler);
    signal(SIGILL, SignalExceptionHandler);
    signal(SIGSEGV, SignalExceptionHandler);
    signal(SIGFPE, SignalExceptionHandler);
    signal(SIGBUS, SignalExceptionHandler);
    signal(SIGPIPE, SignalExceptionHandler);
}

void SignalExceptionHandler(int signal) {
    void *callstack[128];
    int frames = backtrace(callstack,128);
    char **strs = backtrace_symbols(callstack, frames);
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i = 0; i < frames; i ++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    /* 存储crash信息 */
}

void HandlerNSException(NSException *exception) {
    __unused NSString *reason = [exception reason];
    __unused NSString *name = [exception name];
    
    /* 存储crash信息 */
}

/// 监听整个应用的内存警告
/// @param application application
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    // 清除内存缓存
    [[[SDWebImageManager sharedManager] imageCache] clearWithCacheType:SDImageCacheTypeMemory completion:^{
        NSLog(@"缓存清理完成");
    }];
    // 取消所有下载
    [[SDWebImageManager sharedManager] cancelAll];
}
#pragma mark - 紧急方法，可使用JSPatch重写

- (void)urgentMethod{}

@end
