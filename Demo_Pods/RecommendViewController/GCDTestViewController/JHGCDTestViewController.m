//
//  JHGCDTestViewController.m
//  Demo_Pods
//
//  Created by gjh on 2021/1/30.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHGCDTestViewController.h"

@interface JHGCDTestViewController ()

@end

@implementation JHGCDTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"B--viewDidLoad");
//    [self testDemo];
    [self threadTest];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"B--viewWillAppear");
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"B--viewDidAppear");
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"B--viewWillDisappear");
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"B--viewDidDisappear");
}
#pragma mark - 多线程示例代码

- (void)dispatchGroup {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        NSLog(@"A---%@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"B---%@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"C---%@", [NSThread currentThread]);
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"D-任务完成--%@", [NSThread currentThread]);
    });
}
- (void)dispatchBarrier {
    /*注意，这里用到的dispatch_barrier_async如果使用的队列是dispatch_global_queue，那么就等同意dispatch_async，起不到阻塞的作用。我们需要自己创建并发队列，然后再执行barrier函数，前面ABC三个任务随机，后面DE随机，但是DE的执行必须是等待ABC任务执行完的。 */
    dispatch_queue_t queue = dispatch_queue_create("com.gjh", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"A---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"B---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"C---%@", [NSThread currentThread]);
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"栅栏函数---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"D---%@", [NSThread currentThread]);
    });
}
- (void)operationQueue {
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"A---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"B---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"C---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operation4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"D---%@", [NSThread currentThread]);
    }];
    [operation4 addDependency:operation1];
    [operation4 addDependency:operation2];
    [operation4 addDependency:operation3];
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue addOperations:@[operation1,operation2,operation3,operation4] waitUntilFinished:YES];
    NSLog(@"完成之后的操作");
}
- (void)threadTest {
    
    int a = 9;
    void(^blockName)(void) = ^() {
        NSLog(@"hello world-%d",a);
    };
    NSLog(@"fuzhizhiqian %@",[^ {
        NSLog(@"hello world-%d",a);
    } class]);
    blockName();
    /* 如何实现ABC三个网络请求都回来之后->执行D这样的操作 */
    // 使用group方式
    [self dispatchGroup];
    // 使用栅栏函数
    [self dispatchBarrier];
    // NSOperation  :通过任务之间的依赖关系执行，最后的参数YES的时候是会阻塞当前线程，执行完之后再往后执行，NO的话就不阻塞
    [self operationQueue];
    
    
    /* 上一题中的ABC三个任务改成异步任务(如AFN网络请求)、全部回调成功后进行数据整合。 */
    // group + 信号量
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    dispatch_group_async(group, queue, ^{
        NSLog(@"A---%@", [NSThread currentThread]);
        // 网络耗时操作
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"网络请求1---%@", [NSThread currentThread]);
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"B---%@", [NSThread currentThread]);
        // 网络耗时操作
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"网络请求2---%@", [NSThread currentThread]);
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"C---%@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"D---%@", [NSThread currentThread]);
        // 网络耗时操作
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"网络请求3---%@", [NSThread currentThread]);
            dispatch_semaphore_signal(semaphore);
        });
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"结束");
    });
    
}

- (void)testDemo {
    dispatch_queue_t serialQueue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1--%@", [NSThread currentThread]);
    dispatch_async(serialQueue, ^{
        NSLog(@"2--%@", [NSThread currentThread]);
    });
    NSLog(@"3--%@", [NSThread currentThread]);
    dispatch_sync(serialQueue, ^{
        NSLog(@"4--%@", [NSThread currentThread]);
    });
    NSLog(@"5--%@", [NSThread currentThread]);
}
@end
