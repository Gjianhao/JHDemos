//
//  NSFileManager+JHChat.h
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/4.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSFileManager+TLPaths.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (JHChat)

/// 图片 - 设置
/// @param imageName 图片名称
+ (NSString *)pathUserSettingImage:(NSString *)imageName;

/// 图片 - 聊天
/// @param imageName 图片名称
+ (NSString *)pathUserChatImage:(NSString *)imageName;

/// 图片 - 聊天背景
/// @param imageName 图片名称
+ (NSString *)pathUserChatBackgroundImage:(NSString *)imageName;

/// 图片 - 用户头像
/// @param imageName 图片名称
+ (NSString *)pathUserAvatar:(NSString *)imageName;

/// 图片 - 屏幕截图
/// @param imageName 图片名称
+ (NSString *)pathScreenshotImage:(NSString *)imageName;


/// 图片 — 本地通讯录
/// @param imageName 图片名称
+ (NSString *)pathContactsAvatar:(NSString *)imageName;


/// 聊天语音
/// @param voiceName 图片名称
+ (NSString *)pathUserChatVoice:(NSString *)voiceName;


/// 表情
/// @param groupID 图片名称
+ (NSString *)pathExpressionForGroupID:(NSString *)groupID;


/// 数据 — 本地通讯录
+ (NSString *)pathContactsData;

/// 数据库 - 非IM
+ (NSString *)pathDBCommon;

/// 数据库 - IM
+ (NSString *)pathDBMessage;

/// 缓存
/// @param filename 文件名
+ (NSString *)cacheForFile:(NSString *)filename;

@end

NS_ASSUME_NONNULL_END
