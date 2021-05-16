//
//  JHUserManager.h
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/1.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JHUser;

NS_ASSUME_NONNULL_BEGIN

@interface JHUserManager : NSObject

@property (nonatomic, strong) JHUser *user;

@property (nonatomic, strong, readonly) NSString *userID;

@property (nonatomic, assign, readonly) BOOL isLogin;

+ (JHUserManager *)sharedInstance;

- (void)loginTestAccount;

@end

NS_ASSUME_NONNULL_END
