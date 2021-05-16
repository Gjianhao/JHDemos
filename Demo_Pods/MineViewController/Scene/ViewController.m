//
//  ViewController.m
//  Demo_Pods
//
//  Created by gjh on 2020/8/25.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//+ (instancetype) defaultInstance {
//    static AFImageDownloader *downloader = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        downloader = [[self alloc] init];
//    });
//    return downloader;
//}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"12");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /**
     1、先创建一个 NSURLSession 类，
     2、再创建一个下载任务类：
     NSURLSessionDownloadTask 类，将 session 加入到下载任务中。
     3、开启下载任务。
     */
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"http://v.juhe.cn/toutiao/index?type=top&key=97ad001bfcc2082e2eeaf798bad3d54e"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
//        NSError *jsonError;
//        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
//        NSLog(@"");
    }];
    
    [dataTask resume];

    //    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:but];
    
//    BOOL isYes = [but isKindOfClass:[UIView class]]; // 本类实例对象或者子类实例对象
//
//    BOOL isyess = [but isMemberOfClass:[UIView class]]; // 只能是本类实例对象
    
//    [but respondsToSelector:@selector(setActive:animated:)];
//    [UIButton instancesRespondToSelector:@selector(setActive:animated:)];
    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
//    DetailNewsViewController *sec = [[DetailNewsViewController alloc] init];
//    [nav pushViewController:sec animated:YES];
    
    
//    [self swizzlingMethod];
//    [self originalFunction];
//    [self swizzlingFuncotion];
    
//    NSArray *nums = @[@2,@7,@11,@15];
//    NSInteger target = 9;
//    for (int i = 0; i < nums.count; i++) {
//        NSInteger tmp = target - [[nums objectAtIndex:i] integerValue];
//        for (int j = 0; j < nums.count; j++) {
//            if (tmp == [nums[j] integerValue]) {
//                return;
//            }
//        }
//    }
    
//    [self performSelector:@selector(func)];
    
//    NSURLConnection *con = [[NSURLConnection alloc] init];
//    [MGJRouter registerURLPattern:@"" toHandler:^(NSDictionary *routerParameters) {
//        ;
//    }];
    
//    NSURL *url = [NSURL URLWithString:@"https://github.com/AFNetworking/AFNetworking"];
//    // 1、获取 NSURLSession对象
//    NSURLSession *session = [NSURLSession sharedSession];
//    // 2、通过 session 创建 task 任务
//    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        // 处理
//    }];
//    // 3、将挂起的 task 重新执行
//    [task resume];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    //2.封装参数
//        NSDictionary *dict = @{
//                               @"username":@"Lion",
//                               @"pwd":@"1314",
//                               @"type":@"JSON"
//                               };
//    [manager GET:@"需要请求的 url"
//      parameters:dict
//         headers:nil
//        progress:nil
//         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"成功了");
//        }
//         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"失败了");
//        }];
//    NSRunLoop *loop = [[NSRunLoop alloc] init];
//    loop.currentMode = nil;
//    CFRunLoopRun();
}

// 实现 funcMethod 方法
//void funcMethod(id obj, SEL _cmd) {
//    NSLog(@"%s", __func__);
//}


/// 动态解析方法
/// @param sel sel description
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    // 如果执行 func 方法，就动态解析，指定新的 IMP
//    if (sel == @selector(func)) {
//        class_addMethod([self class], sel, (IMP)funcMethod, "v@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}


//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    return YES;
//}
//
///// 消息接收者重定向
///// @param aSelector aSelector description
//- (id)forwardingTargetForSelector:(SEL)aSelector {
////    if (aSelector == @selector(func)) {
////        return [[Person alloc] init];
////    }
////    return [super forwardingTargetForSelector:aSelector];
//    return nil;
//}
//
///// 获取函数的参数和返回值类型，返回签名
///// @param aSelector aSelector description
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    if (aSelector == @selector(func)) {
//        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    }
//    return [super methodSignatureForSelector:aSelector];
//}
//
///// 消息重定向
///// @param anInvocation anInvocation description
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    SEL sel = anInvocation.selector; // 从anInvocation获取消息
//
//    Person *p = [[Person alloc] init];
//    if ([p respondsToSelector:sel]) {  // 判断Person 对象方法是否可以响应 sel
//        [anInvocation invokeWithTarget:p]; // 可以响应，将消息转发给其他对象处理
//    } else {
//        [self doesNotRecognizeSelector:sel];  // 不可以响应，
//    }
//}
// 区别就在于 -forwardingTargetForSelector: 只能将消息转发给一个对象。而 -forwardInvocation: 可以将消息转发给多个对象。

#pragma mark - Method Swizzling 动态方法交换
//- (void)swizzlingMethod {
//    Class class = [self class];
//
//    SEL originalSelector = @selector(originalFunction);
//    SEL swizzlingSelector = @selector(swizzlingFuncotion);
//
//    Method originalMethod = class_getInstanceMethod(class, originalSelector);
//    Method swizzledMethod = class_getInstanceMethod(class, swizzlingSelector);
//
//    // 交换
//    method_exchangeImplementations(originalMethod, swizzledMethod);
//}
//
//- (void)originalFunction {
//    NSLog(@"%s", __func__);
//}
//
//- (void)swizzlingFuncotion {
//    NSLog(@"%s", __func__);
//}

- (void)dealloc
{
    // 移除通知中心的监听
    // 移除 KVO 监听
    // 取消定时器，并将定时器置空(nil)，NSTimer，GCDTimer
    // 释放非Objective-C对象的内存，如CFRelease(...), free(...)
    // 释放GCD队列：dispatch_release(_ioQueue);
}


@end
