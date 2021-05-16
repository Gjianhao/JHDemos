//
//  DBManager.m
//  Demo_Pods
//
//  Created by gjh on 2020/12/12.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "DBManager.h"
#import <sqlite3.h>
#import "NewsListDAL.h"
#import "FMDB.h"

@interface DBManager ()

@property (nonatomic, assign) sqlite3 *db;

@property (nonatomic, strong) FMDatabase *dataBase;

@end

@implementation DBManager

#pragma mark - 单例
+ (instancetype)sharedInstance {
    static DBManager *dbManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbManager = [[DBManager alloc] init];
    });
    return dbManager;
}
#pragma mark - 创建数据库
- (BOOL)createDatabase {
    // 创建数据库文件
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"database.sqlite"];
    NSLog(@"数据库沙盒路径：%@", path);
    
//    FMDatabase *dataBase = [FMDatabase databaseWithPath:path];
//    self.dataBase = dataBase;
//    BOOL success = [dataBase open];
    int success = sqlite3_open(path.UTF8String, &_db);
    if (success == SQLITE_OK) {
        NSLog(@"数据库创建成功");
        // 创建各个表
        [self createAllTable];
        return YES;
    } else {
        return NO;
    }
}

/// 执行除查询语句外的语句
/// @param sql sql语句
- (BOOL)execSQL:(NSString *)sql {
    int result = sqlite3_exec(self.db, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        return YES;
    }
    return NO;
}

#pragma mark - 创建所有的表
- (BOOL)createAllTable {
    BOOL success;
    success = [[NewsListDAL sharedInstance] createNewsListTable];
    return success;
}
@end
