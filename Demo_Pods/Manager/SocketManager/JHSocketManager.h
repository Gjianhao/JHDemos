//
//  JHSocketManager.h
//  Demo_Pods
//
//  Created by gjh on 2021/3/18.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DisConnectType) {
    DisConnectTypeByServer = 1001,
    DisConnectTypeByUser
};

@interface JHSocketManager : NSObject

+ (instancetype)shareManager;

- (void)connect;

- (void)disConnect;

- (void)sendMessage:(NSString *)msg;

- (void)ping;

@end

NS_ASSUME_NONNULL_END
