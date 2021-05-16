//
//  JHChatServer.m
//  Demo_Pods
//
//  Created by gjh on 2021/1/17.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHChatServer.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface JHChatServer ()<GCDAsyncSocketDelegate> {
    dispatch_queue_t _globalQueue;
}
// 客户端所连接的 socket 数组
@property (nonatomic, strong) NSMutableArray *clientArr;
// 服务端的 socket,(开放端口,监听客户端socket 的连接)
@property (nonatomic, strong) GCDAsyncSocket *serverSocket;

@property (nonatomic, strong) NSMutableDictionary *clientPhoneTimeDicts;

@end

@implementation JHChatServer

- (instancetype)init {
    self = [super init];
    if (self) {
        // 1.创建服务端的 socket
        _globalQueue = dispatch_get_main_queue();
        _serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:_globalQueue];
    }
    return self;
}
// 懒加载
- (NSMutableArray *)clientArr {
    if (!_clientArr) {
        _clientArr = [[NSMutableArray alloc] init];
    }
    return _clientArr;
}

- (void)startChatServer {
    
    // 2.打开监听端口
    NSError *error;
    [_serverSocket acceptOnPort:54321 error:&error];
    if (!error) {
        NSLog(@"开启服务成功");
    } else {
        NSLog(@"开启服务失败");
    }
}

#pragma mark - 代理方法
// 有客户端建立连接,连接上新的客户端 socket
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    NSLog(@"%s", __func__);
    // sock 服务端的socket 服务端的 socket 只负责客户端的连接,不负责数据的读取
    // 保存客户端的 socket
    [self.clientArr addObject:newSocket];
    // 添加定时器
//    [self addTimer];
    [SVProgressHUD showInfoWithStatus:@"链接成功"];
    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"客户端IP: %@-------端口: %d", newSocket.connectedHost, newSocket.connectedPort]];
    // 先读取数据,这里要用客户端的 socket
    [newSocket readDataWithTimeout:-1 tag:100];
}
// 接收客户端传递过来的数据, 读取客户端的数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
//    NSLog(@"%s", __func__);
    // 接收到数据
    NSString *receiveStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // 去掉回车和换行字符
    receiveStr = [receiveStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    receiveStr = [receiveStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    // 判断是登录指令还是发送聊天数据的指令
    if ([receiveStr hasPrefix:@"iam:"]) {
        // 登录指令  返回 xxx has joined
        // 获取用户名
        NSString *user = [receiveStr componentsSeparatedByString:@":"][1];
        // 响应给客户端的数据
        NSString *respStr = [user stringByAppendingString:@"has joined!"];
        // 客户端的 socket
        [sock writeData:[respStr dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    }
    // 聊天指令
    if ([receiveStr hasPrefix:@"msg:"]) {
        // 截取聊天内容
        NSString *msg = [receiveStr componentsSeparatedByString:@":"][1];
        [sock writeData:[msg dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    }
    // quit 指令
    if ([receiveStr hasPrefix:@"quit"]) {
        // 断开链接
        [sock disconnect];
        // 移除 socket
        [self.clientArr removeObject:sock];
    }
    // // 第一次读取到的数据直接添加
    if (self.clientPhoneTimeDicts.count == 0) {
//        [self.clientPhoneTimeDicts setObject:[self getCurrentTime] forKey:text];
    } else {
        // 键相同,直接覆盖,值改变
        [self.clientPhoneTimeDicts enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//            [self.clientPhoneTimeDicts setObject:[self getCurrentTime] forKey:text];
        }];
    }
    [sock readDataWithTimeout:-1 tag:0];
}
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    [sock readDataWithTimeout:-1 tag:100];
}

- (void)sendMessage {
    if (self.clientArr == nil) {
        return;
    }
    //
    NSData *data = [@"123" dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj writeData:data withTimeout:-1 tag:0];
    }];
}
@end
