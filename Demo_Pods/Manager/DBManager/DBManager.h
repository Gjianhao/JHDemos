//
//  DBManager.h
//  Demo_Pods
//
//  Created by gjh on 2020/12/12.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBManager : NSObject

+ (instancetype)sharedInstance;
#pragma mark - 创建数据库
- (BOOL)createDatabase;
/// 执行除查询语句外的语句
/// @param sql sql语句
- (BOOL)execSQL:(NSString *)sql;
@end

NS_ASSUME_NONNULL_END
