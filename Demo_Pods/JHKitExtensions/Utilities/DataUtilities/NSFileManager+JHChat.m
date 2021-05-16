//
//  NSFileManager+JHChat.m
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/4.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "NSFileManager+JHChat.h"
#import "JHUserManager.h"

@implementation NSFileManager (JHChat)

+ (NSString *)pathUserSettingImage:(NSString *)imageName {
    NSString *path = [NSString stringWithFormat:@"%@/User/%@/Setting/Images/", [NSFileManager documentsPath], [JHUserManager sharedInstance].userID];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DDLogError(@"文件创建失败：%@", path);
        }
    }
    return [path stringByAppendingString:imageName];
}

+ (NSString *)pathUserChatImage:(NSString*)imageName
{
    NSString *path = [NSString stringWithFormat:@"%@/User/%@/Chat/Images/", [NSFileManager documentsPath], [JHUserManager sharedInstance].userID];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DDLogError(@"文件创建失败：%@", path);
        }
    }
    return [path stringByAppendingString:imageName];
}

+ (NSString *)pathUserChatBackgroundImage:(NSString *)imageName
{
    NSString *path = [NSString stringWithFormat:@"%@/User/%@/Chat/Background/", [NSFileManager documentsPath], [JHUserManager sharedInstance].userID];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DDLogError(@"文件创建失败：%@", path);
        }
    }
    return [path stringByAppendingString:imageName];
}

+ (NSString *)pathUserAvatar:(NSString *)imageName
{
    NSString *path = [NSString stringWithFormat:@"%@/User/%@/Chat/Avatar/", [NSFileManager documentsPath], [JHUserManager sharedInstance].userID];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DDLogError(@"File Create Failed: %@", path);
        }
    }
    return [path stringByAppendingString:imageName];
}

+ (NSString *)pathContactsAvatar:(NSString *)imageName
{
    NSString *path = [NSString stringWithFormat:@"%@/Contacts/Avatar/", [NSFileManager documentsPath]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DDLogError(@"File Create Failed: %@", path);
        }
    }
    return [path stringByAppendingString:imageName];
}

+ (NSString *)pathUserChatVoice:(NSString *)voiceName
{
    NSString *path = [NSString stringWithFormat:@"%@/User/%@/Chat/Voices/", [NSFileManager documentsPath], [JHUserManager sharedInstance].userID];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DDLogError(@"File Create Failed: %@", path);
        }
    }
    return [path stringByAppendingString:voiceName];
}


+ (NSString *)pathExpressionForGroupID:(NSString *)groupID
{
    NSString *path = [NSString stringWithFormat:@"%@/Expression/%@/", [NSFileManager documentsPath], groupID];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DDLogError(@"File Create Failed: %@", path);
        }
    }
    return path;
}

+ (NSString *)pathContactsData
{
    NSString *path = [NSString stringWithFormat:@"%@/Contacts/", [NSFileManager documentsPath]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DDLogError(@"File Create Failed: %@", path);
        }
    }
    return [path stringByAppendingString:@"Contacts.dat"];
}

+ (NSString *)pathScreenshotImage:(NSString *)imageName
{
    NSString *path = [NSString stringWithFormat:@"%@/Screenshot/", [NSFileManager documentsPath]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DDLogError(@"File Create Failed: %@", path);
        }
    }
    return [path stringByAppendingString:imageName];
}

#pragma mark - 数据库路径

+ (NSString *)pathDBCommon
{
    NSString *path = [NSString stringWithFormat:@"%@/User/%@/Setting/DB/", [NSFileManager documentsPath], [JHUserManager sharedInstance].userID];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DDLogError(@"文件创建失败：%@", path);
        }
    }
    return [path stringByAppendingString:@"common.sqlite3"];
}

+ (NSString *)pathDBMessage
{
    NSString *path = [NSString stringWithFormat:@"%@/User/%@/Chat/DB/", [NSFileManager documentsPath], [JHUserManager sharedInstance].userID];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            DDLogError(@"文件创建失败：%@", path);
        }
    }
    return [path stringByAppendingString:@"message.sqlite3"];
}

+ (NSString *)cacheForFile:(NSString *)filename
{
    return [[NSFileManager cachesPath] stringByAppendingString:filename];
}
@end
