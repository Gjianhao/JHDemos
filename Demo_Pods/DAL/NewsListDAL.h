//
//  NewsListDAL.h
//  Demo_Pods
//
//  Created by gjh on 2020/12/12.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface NewsListDAL : NSObject

+ (instancetype)sharedInstance;
#pragma mark - 创建新闻列表数据库表
- (BOOL)createNewsListTable;
#pragma mark - 给表中增加数据
- (BOOL)addNewsListDataWithModelArr:(NSArray<NewsItemModel *> *)modelArr;
@end

NS_ASSUME_NONNULL_END
