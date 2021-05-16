//
//  MineViewController.m
//  Demo_Pods
//
//  Created by gjh on 2020/10/24.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "MineViewController+Protect.h"
#import "ViewController.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
#import "JHChatServer.h"

@interface MineViewController ()<NSStreamDelegate, GCDAsyncSocketDelegate> {
    NSInputStream *_inputStream;
    NSOutputStream *_outputStream;
}
// 客户端 socket
@property (nonatomic, strong) GCDAsyncSocket *clientSocket;
// 是否连接成功
@property (nonatomic, assign) BOOL connected;
// 建立心跳连接
@property (nonatomic, strong) NSTimer *connectTimer;

@end

@implementation MineViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"icon.bundle/home@2x.png"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon.bundle/home_selected@2x.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    UIButton *serverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [serverBtn setTitle:@"开启服务端" forState:UIControlStateNormal];
    [serverBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    serverBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [serverBtn addTarget:self action:@selector(startServer) forControlEvents:UIControlEventTouchUpInside];
    [serverBtn sizeToFit]; // 手动计算大小
    [self.view addSubview:serverBtn];
    [serverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@100);
    }];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"登录" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(logininServer) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn sizeToFit]; // 手动计算大小
    [self.view addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@100);
    }];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"连接" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftBtn addTarget:self action:@selector(linkServer) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn sizeToFit]; // 手动计算大小
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@150);
    }];
    // 设置不起作用
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"连接" style:UIBarButtonItemStyleDone target:self action:@selector(linkServer)];
    self.navigationController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(logininServer)];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor redColor];
}

#pragma mark - 添加定时器
- (void)addTimer {
    // 长连接定时器
    self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];
    // 把定时器添加到当前运行循环,并且调为通用模式
    [[NSRunLoop currentRunLoop] addTimer:self.connectTimer forMode:NSRunLoopCommonModes];
}
// 心跳连接

/// 心跳连接中发送给服务端的数据只是作为测试代码,根据你们公司需求,或者和后台商定好心跳包的数据以及发送心跳的时间间隔.
/// 因为这个项目的服务端socket也是我写的,所以,我自定义心跳包协议.
/// 客户端发送心跳包,服务端也需要有对应的心跳检测,以此检测客户端是否在线.
- (void)longConnectToSocket {
    // 发送固定格式的数据,指令@"longConnect"
    float version = [[UIDevice currentDevice] systemVersion].floatValue;
    NSString *longConnect = [NSString stringWithFormat:@"123%f", version];
    NSData *data = [longConnect dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
}

#pragma mark - 导航栏按钮的点击事件
- (void)startServer {
    JHChatServer *chatServer = [[JHChatServer alloc] init];
    [chatServer startChatServer];
    // 开启运行循环
    [[NSRunLoop currentRunLoop] run];
}

- (void)linkServer {
    // iOS 实现socket的链接,使用 C语言
    // 1.与服务器进行三次握手链接
    NSString *host = @"127.0.0.1";
    int port = 8000;
//    [self oldLinkMethod:host port:port];
    // 全局队列  主队列(必须为主队列)
    // 创建一个Socket 对象(需要全局)
    self.clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    // 链接
    NSError *error = nil;
    self.connected = [self.clientSocket connectToHost:host onPort:port error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
}

#pragma mark - 登录
- (void)logininServer {
    // 登录请求 使用输出流
    // 拼接登录的指令
    NSString *loginStr = @"iam:zhangsan";
//    [self oldLogin:loginStr];
    [self.clientSocket writeData:[loginStr dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:101];
}
#pragma mark - socket的代理
// 链接成功
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"%s", __func__);
    [SVProgressHUD showInfoWithStatus:@"链接成功"];
    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"服务器IP: %@-------端口: %d", host, port]];
    // 连接成功 开启定时器, 心跳包开启
    [self addTimer];
    // 连接后,可读取服务端的数据
    [self.clientSocket readDataWithTimeout:-1 tag:0]; // 这个方法的作用就是去读取当前消息队列中的未读消息。记住，这里不调用这个方法，消息回调的代理是永远不会被触发的。
    self.connected = YES;
}
// 客户端socket断开链接
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    if (err) {
        NSLog(@"链接失败");
    } else {
        self.clientSocket = nil;
        self.clientSocket.delegate = nil;
        self.connected = NO;
        [self.connectTimer invalidate];
        NSLog(@"正常断开");
    }
}
// 数据发送成功
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    NSLog(@"%s", __func__);
    // 发送完数据然后手动读取,自动调用下面的 read 代理方法
    [sock readDataWithTimeout:-1 tag:tag];
}
// 读取数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSLog(@"%@", [NSThread currentThread]);// 当前是子线程
    NSString *receiverStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [SVProgressHUD showInfoWithStatus:receiverStr];
    if (tag == 101) {
        // 登录指令
    } else if (tag == 102) {
        // 聊天数据
        // 刷新列表
    }
    // 读取服务端数据值后,能再次读取
    [self.clientSocket readDataWithTimeout:-1 tag:0];
    NSLog(@"%s----%@", __func__, receiverStr);
}




#pragma mark - ---------------------------------之前的 C语言老方法-------------------------------------------
- (void)oldLogin:(NSString *)loginStr {
    // uint8_t * 字符数组
    NSData *data = [loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [_outputStream write:data.bytes maxLength:data.length];
}
#pragma mark - 之前的链接方式
- (void)oldLinkMethod:(NSString *)host port:(int)port {
    // 2.定义输入输出流
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    // 3.为输入输出流分配内存空间
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef _Null_unspecified)(host), port, &readStream, &writeStream);
    // 4.把C语言的输入输出流转换成OC对象
    _inputStream = (__bridge NSInputStream *)(readStream);
    _outputStream = (__bridge NSOutputStream *)(writeStream);
    // 5.设置代理,监听数据接收的状态
    _outputStream.delegate = self;
    _inputStream.delegate = self;
    // 把输入输出流添加到主运行循环
    // 主运行循环是监听网络状态
    [_inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    // 6.开启输入输出流
    [_inputStream open];
    [_outputStream open];
}
#pragma mark - NSStreamDelegate (C语言)
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    /*
     NSStreamEventOpenCompleted = 1UL << 0,
     NSStreamEventHasBytesAvailable = 1UL << 1,
     NSStreamEventHasSpaceAvailable = 1UL << 2,
     NSStreamEventErrorOccurred = 1UL << 3,
     NSStreamEventEndEncountered = 1UL << 4
     */
    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"%@", aStream);
            NSLog(@"成功建立链接,形成输入输出流的传输通道");
            break;
        case NSStreamEventHasBytesAvailable:
            NSLog(@"有数据可读");
            [self readData];
            break;
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"可以发送数据");
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"有错误发生,链接失败");
            break;
        case NSStreamEventEndEncountered:
            NSLog(@"正常的断开链接");
            break;
        default:
            break;
    }
}
#pragma mark - 读取服务器返回的数据
- (void)readData {
    // 定义一个缓冲区,只能放 1024 个字节
    uint8_t buf[1024];
    // 读取数据
    // len 为服务器读取到的实际字节数
    NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];
    // 把缓冲区里的实际字节数转换成字符串
    NSString *receiverStr = [[NSString alloc] initWithBytes:buf length:len encoding:NSUTF8StringEncoding];
    NSLog(@"%@", receiverStr);
}

#pragma mark - 发送数据
- (void)sendDataToHost:(NSString *)str {
    // uint8_t * 字符数组
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [_outputStream write:data.bytes maxLength:data.length];
}
@end
