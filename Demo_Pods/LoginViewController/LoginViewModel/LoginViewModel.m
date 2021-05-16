//
//  LoginViewModel.m
//  Demo_Pods
//
//  Created by gjh on 2020/12/8.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    // 处理文本框业务逻辑, 观察这两个值是否改变
    _loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, account), RACObserve(self, pwd)] reduce:^id(NSString *account, NSString *pwd) {
        return @(account.length && pwd.length);
    }];
    
    // 处理登录的点击命令
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // 执行命令就会调用
        // block作用：事件处理
        // 发送登录请求
        NSLog(@"发送登录请求");
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 发送数据
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"请求登录的数据"];
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
    
    [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // 监听命令执行过程
    [[self.loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if (x.boolValue) {
            NSLog(@"正在登录");
            [SVProgressHUD showWithStatus:@"正在登录"];
        } else {
            NSLog(@"登录完成");
            [SVProgressHUD showSuccessWithStatus:@"登录完成"];
        }
    }];
}

@end
