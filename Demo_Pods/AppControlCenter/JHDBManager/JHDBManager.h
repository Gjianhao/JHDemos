//
//  JHDBManager.h
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/4.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHDBManager : NSObject

/// DB队列（除IM相关）
@property (nonatomic, strong) FMDatabaseQueue *commonQueue;

/// 与IM相关的DB队列
@property (nonatomic, strong) FMDatabaseQueue *messageQueue;

+ (JHDBManager *)sharedInstance;

@end

NS_ASSUME_NONNULL_END
