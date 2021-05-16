//
//  JHBarrierUserCenter.m
//  Demo_Pods
//
//  Created by gjh on 2021/3/14.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHBarrierUserCenter.h"

@interface JHBarrierUserCenter () {
    // 定义一个并发队列
    dispatch_queue_t concurrent_queue;
    
    // 用户数据中心，可能多个线程需要数据访问
    NSMutableDictionary *userCenterDic;
}

@end
/// 多读单写模型
@implementation JHBarrierUserCenter

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 通过宏定义 创建一个并发队列
        concurrent_queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
        // 创建数据容器
        userCenterDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)objectForKey:(NSString *)key {
    __block id obj;
    dispatch_sync(concurrent_queue, ^{
        obj = [userCenterDic objectForKey:key];
    });
    return obj;
}


- (void)setObject:(id)obj forKey:(NSString *)key {
    // 异步栅栏调用设置数据
    dispatch_barrier_async(concurrent_queue, ^{
        [self->userCenterDic setObject:obj forKey:key];
    });
}
@end
