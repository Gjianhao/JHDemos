//
//  JHDBUserStore.m
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/5.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHDBUserStore.h"
#import "JHDBUserStoreSQL.h"
#import "JHUser.h"

@implementation JHDBUserStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dbQueue = [JHDBManager sharedInstance].commonQueue;
        BOOL isOK = [self createTable];
        if (!isOK) {
            DDLogError(@"DB: 用户表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable {
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_USER_TABLE, USER_TABLE_NAME];
    return [self createTable:USER_TABLE_NAME withSQL:sqlString];
}

- (BOOL)updateUser:(JHUser *)user {
    NSString *sqlString = [NSString stringWithFormat:SQL_UPDATE_USER, USER_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        TLNoNilString(user.userID),
                        TLNoNilString(user.username),
                        TLNoNilString(user.nikeName),
                        TLNoNilString(user.avatarURL),
                        TLNoNilString(user.remarkName),
                        @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    return ok;
}

- (JHUser *)userByID:(NSString *)userID {
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_USER_BY_ID, USER_TABLE_NAME, userID];
    __block JHUser * user;
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            user = [self p_createUserByFMResultSet:retSet];
        }
        [retSet close];
    }];
    return user;
}

- (NSArray *)userData {
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_USERS, USER_TABLE_NAME];
    
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            JHUser *user = [self p_createUserByFMResultSet:retSet];
            [data addObject:user];
        }
        [retSet close];
    }];
    
    return data;
}

- (BOOL)deleteUsersByUid:(NSString *)uid {
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_USER, USER_TABLE_NAME, uid];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

#pragma mark - # Private Methods
- (JHUser *)p_createUserByFMResultSet:(FMResultSet *)retSet {
    JHUser *user = [[JHUser alloc] init];
    user.userID = [retSet stringForColumn:@"uid"];
    user.username = [retSet stringForColumn:@"username"];
    user.nikeName = [retSet stringForColumn:@"nikename"];
    user.avatarURL = [retSet stringForColumn:@"avatar"];
    user.remarkName = [retSet stringForColumn:@"remark"];
    return user;
}


@end
