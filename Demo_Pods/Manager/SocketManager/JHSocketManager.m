//
//  JHSocketManager.m
//  Demo_Pods
//
//  Created by gjh on 2021/3/18.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHSocketManager.h"
#import <SocketRocket/SocketRocket.h>

#define dispatch_main_safe_async(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }

static NSString *host = @"127.0.0.1";
static const uint16_t port = 6969;

@interface JHSocketManager ()<SRWebSocketDelegate> {
    SRWebSocket *webSocket;
    NSTimer *heartBeat;
    NSTimeInterval reConnectTime;
}

@end

@implementation JHSocketManager

+ (instancetype)shareManager {
    static JHSocketManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JHSocketManager alloc] init];
        [instance initSocket];
    });
    return instance;
}

/// 初始化链接
- (void)initSocket {
    if (!webSocket) {
        NSString *urlString = [NSString stringWithFormat:@"ws://%@:%d", host, port];
        webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
        webSocket.delegate = self;
        // 设置代理线程
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 1;
        [webSocket setDelegateOperationQueue:queue];
        // 链接
        [webSocket open];
    }
}

/// 初始化心跳
- (void)initHeartBeat {
    dispatch_main_safe_async(^{
        [self destoryHeartBeat];
        __weak typeof(self) weakSelf = self;
        heartBeat = [NSTimer scheduledTimerWithTimeInterval:3*60 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"heart");
            // 和服务器约定好发送什么作为心跳标识，尽可能的减少心跳包的大小
            [weakSelf sendMessage:@"heart"];
        }];
        [[NSRunLoop currentRunLoop] addTimer:heartBeat forMode:NSRunLoopCommonModes];
    })
}

/// 取消心跳
- (void)destoryHeartBeat {
    dispatch_main_safe_async(^{
        if (heartBeat) {
            [heartBeat invalidate];
            heartBeat = nil;
        }
    })
}
#pragma mark - 对外的一些接口

//建立连接
- (void)connect
{
    [self initSocket];
    
    //每次正常连接的时候清零重连时间
    reConnectTime = 0;
}

//断开连接
- (void)disConnect
{
    
    if (webSocket) {
        [webSocket closeWithCode:DisConnectTypeByUser reason:@"用户主动断开"];
        webSocket = nil;
    }
}


//发送消息
- (void)sendMessage:(NSString *)msg
{
    [webSocket send:msg];
    
}

//重连机制
- (void)reConnect
{
    [self disConnect];
    
    //超过一分钟就不再重连 所以只会重连5次 2^5 = 64
    if (reConnectTime > 64) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        webSocket = nil;
        [self initSocket];
    });
    
    
    //重连时间2的指数级增长
    if (reConnectTime == 0) {
        reConnectTime = 2;
    }else{
        reConnectTime *= 2;
    }

}


//pingPong
- (void)ping{
    
    if (webSocket) {
        [webSocket sendPing:nil];
    }
}



#pragma mark - SRWebSocketDelegate

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSLog(@"服务器返回收到消息:%@",message);
}


- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"连接成功");
    
    //连接成功了开始发送心跳
    [self initHeartBeat];
}

//open失败的时候调用
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@"连接失败.....\n%@",error);
    
    //失败了就去重连
    [self reConnect];
}

//网络连接中断被调用
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{

//    NSLog(@"被关闭连接，code:%ld,reason:%@,wasClean:%d",code,reason,wasClean);
    
    //如果是被用户自己中断的那么直接断开连接，否则开始重连
    if (code == DisConnectTypeByUser) {
        NSLog(@"被用户关闭连接，不重连");
        [self disConnect];
    }else{
        NSLog(@"其他原因关闭连接，开始重连...");
        [self reConnect];
    }
    
    
    //断开连接时销毁心跳
    [self destoryHeartBeat];

}

//sendPing的时候，如果网络通的话，则会收到回调，但是必须保证ScoketOpen，否则会crash
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload
{
    NSLog(@"收到pong回调");

}


//将收到的消息，是否需要把data转换为NSString，每次收到消息都会被调用，默认YES
//- (BOOL)webSocketShouldConvertTextFrameToString:(SRWebSocket *)webSocket
//{
//    NSLog(@"webSocketShouldConvertTextFrameToString");
//
//    return NO;
//}

@end
