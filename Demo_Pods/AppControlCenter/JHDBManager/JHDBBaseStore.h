//
//  JHDBBaseStore.h
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/4.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHDBManager.h"

NS_ASSUME_NONNULL_BEGIN

#define     JHTimeStamp(date)   ([NSString stringWithFormat:@"%lf", [date timeIntervalSince1970]])

@interface JHDBBaseStore : NSObject

/// 数据库操作队列(从JHDBManager中获取，默认使用commonQueue)
@property (nonatomic, weak) FMDatabaseQueue *dbQueue;

/**
 *  表创建
 */
- (BOOL)createTable:(NSString*)tableName withSQL:(NSString*)sqlString;

/*
 *  执行带数组参数的sql语句 (增，删，改)
 */
-(BOOL)excuteSQL:(NSString*)sqlString withArrParameter:(NSArray*)arrParameter;

/*
 *  执行带字典参数的sql语句 (增，删，改)
 */
-(BOOL)excuteSQL:(NSString*)sqlString withDicParameter:(NSDictionary*)dicParameter;

/*
 *  执行格式化的sql语句 (增，删，改)
 */
- (BOOL)excuteSQL:(NSString *)sqlString,...;

/**
 *  执行查询指令
 */
- (void)excuteQuerySQL:(NSString*)sqlStr resultBlock:(void(^)(FMResultSet * rsSet))resultBlock;

@end

NS_ASSUME_NONNULL_END
