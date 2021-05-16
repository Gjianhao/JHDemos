//
//  RACDemoViewController.m
//  Demo_Pods
//
//  Created by gjh on 2020/12/7.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "RACDemoViewController.h"
#import "RACReturnSignal.h"

@interface RACDemoViewController ()

@end

@implementation RACDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送上半部分请求");
        [subscriber sendNext:@"上半部分请求"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送下半部分请求");
        [subscriber sendNext:@"下半部分请求"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *concatSignal = [signalA concat:signalB];
    
    [concatSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
}

- (void)map {
    // 创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 绑定信号
    RACSignal *bindSignal = [subject map:^id _Nullable(id  _Nullable value) {
        // 返回的类型就是你需要映射的值
        return @"111";
    }];
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [subject sendNext:@"123"];
}

- (void)flattenMap {
    RACSubject *subject = [RACSubject subject];
    // 绑定信号
    RACSignal *bindSignal = [subject flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        
        // value：就是源信号发送内容
        value = [NSString stringWithFormat:@"xmg:%@", value];
        // 返回信号，就是用来包装成修改内容的值
        return [RACReturnSignal return:value];
    }];
    
    // 订阅信号
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // 发送信号
    [subject sendNext:@"123"];
}
@end
