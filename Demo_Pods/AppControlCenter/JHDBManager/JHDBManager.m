//
//  JHDBManager.m
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/4.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHDBManager.h"
#import "JHUserManager.h"
#import "NSFileManager+JHChat.h"

@implementation JHDBManager

+ (JHDBManager *)sharedInstance {
    static JHDBManager *manager;
    NSString *userID = [JHUserManager sharedInstance].userID;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JHDBManager alloc] initWithUserID:userID];
    });
    return manager;
}

- (id)initWithUserID:(NSString *)userID {
    if (self == [super init]) {
        NSString *commonQueuePath = [NSFileManager pathDBCommon];
        self.commonQueue = [FMDatabaseQueue databaseQueueWithPath:commonQueuePath];
        NSString *messageQueuePath = [NSFileManager pathDBMessage];
        self.messageQueue = [FMDatabaseQueue databaseQueueWithPath:messageQueuePath];
    }
    return self;
}

- (instancetype)init
{
    DDLogError(@"JHDBManager：请使用 initWithUserID: 方法初始化");
    return nil;
}

@end
