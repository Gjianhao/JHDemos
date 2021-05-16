//
//  JHUser.h
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/1.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JHUserChatSetting, JHUserDetail, JHUserSetting;

NS_ASSUME_NONNULL_BEGIN

@interface JHUser : NSObject

/// 用户ID
@property (nonatomic, strong) NSString *userID;

/// 用户名
@property (nonatomic, strong) NSString *username;

/// 昵称
@property (nonatomic, strong) NSString *nikeName;

/// 头像URL
@property (nonatomic, strong) NSString *avatarURL;

/// 头像Path
@property (nonatomic, strong) NSString *avatarPath;

/// 备注名
@property (nonatomic, strong) NSString *remarkName;

/// 界面显示名称
@property (nonatomic, strong, readonly) NSString *showName;


#pragma mark - 其他
@property (nonatomic, strong) JHUserDetail *detailInfo;

@property (nonatomic, strong) JHUserSetting *userSetting;

@property (nonatomic, strong) JHUserChatSetting *chatSetting;


#pragma mark - 列表用
/**
 *  拼音
 *
 *  来源：备注 > 昵称 > 用户名
 */
@property (nonatomic, strong) NSString *pinyin;

@property (nonatomic, strong) NSString *pinyinInitial;

@end

NS_ASSUME_NONNULL_END
