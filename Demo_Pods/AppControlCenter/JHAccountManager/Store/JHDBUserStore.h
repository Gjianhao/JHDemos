//
//  JHDBUserStore.h
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/5.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHDBBaseStore.h"

NS_ASSUME_NONNULL_BEGIN
@class JHUser;
@interface JHDBUserStore : JHDBBaseStore

/// 更新用户信息
/// @param user 用户
- (BOOL)updateUser:(JHUser *)user;

/// 获取用户信息
/// @param userID 用户ID
- (JHUser *)userByID:(NSString *)userID;

/// 查询所有用户信息
- (NSArray *)userData;

/// 删除用户
/// @param uid 用户ID
- (BOOL)deleteUsersByUid:(NSString *)uid;
@end

NS_ASSUME_NONNULL_END
