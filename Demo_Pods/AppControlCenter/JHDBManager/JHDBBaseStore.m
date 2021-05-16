//
//  JHDBBaseStore.m
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/4.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHDBBaseStore.h"

@implementation JHDBBaseStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dbQueue = [JHDBManager sharedInstance].commonQueue;
    }
    return self;
}

- (BOOL)createTable:(NSString *)tableName withSQL:(NSString *)sqlString {
    __block BOOL isOK = YES;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if (![db tableExists:tableName]) {
            isOK = [db executeUpdate:sqlString withArgumentsInArray:@[]];
        }
    }];
    return isOK;
}

- (BOOL)excuteSQL:(NSString *)sqlString withArrParameter:(NSArray *)arrParameter {
    __block BOOL isOK = NO;
    if (self.dbQueue) {
        [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            isOK = [db executeUpdate:sqlString withArgumentsInArray:arrParameter];
        }];
    }
    return isOK;
}

- (BOOL)excuteSQL:(NSString *)sqlString withDicParameter:(NSDictionary *)dicParameter {
    __block BOOL isOK = NO;
    if (self.dbQueue) {
        [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            isOK = [db executeUpdate:sqlString withParameterDictionary:dicParameter];
        }];
    }
    return isOK;
}

- (BOOL)excuteSQL:(NSString *)sqlString,...
{
    __block BOOL ok = NO;
    if (self.dbQueue) {
        va_list args;
        va_list *p_args;
        p_args = &args;
        va_start(args, sqlString);
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            ok = [db executeUpdate:sqlString withVAList:*p_args];
        }];
        va_end(args);
    }
    return ok;
}

- (void)excuteQuerySQL:(NSString*)sqlStr resultBlock:(void(^)(FMResultSet * rsSet))resultBlock
{
    if (self.dbQueue) {
        [_dbQueue inDatabase:^(FMDatabase *db) {
            FMResultSet * retSet = [db executeQuery:sqlStr];
            if (resultBlock) {
                resultBlock(retSet);
            }
        }];
    }
}

@end
