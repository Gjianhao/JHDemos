//
//  NewsListDAL.m
//  Demo_Pods
//
//  Created by gjh on 2020/12/12.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "NewsListDAL.h"
#import "DBManager.h"
#import "NewsItemModel.h"

static NSString * const TABLENAME = @"t_newslist";

@interface NewsListDAL ()


@end

@implementation NewsListDAL

+ (instancetype)sharedInstance {
    static NewsListDAL *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NewsListDAL alloc] init];
    });
    return sharedInstance;
}

#pragma mark - 创建新闻列表数据库表
- (BOOL)createNewsListTable {
    // 创建表 指定字段 执行语句
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT, category TEXT NOT NULL, thumbnail_pic_s TEXT NOT NULL, title TEXT NOT NULL, date TEXT NOT NULL, author_name TEXT NOT NULL, url TEXT NOT NULL, uniquekey TEXT NOT NULL)", TABLENAME];
    
    BOOL creatSuccess = [[DBManager sharedInstance] execSQL:sql];
    if (creatSuccess) {
        NSLog(@"%@创建表成功",TABLENAME);
        return YES;
    } else {
        NSLog(@"%@创建表失败",TABLENAME);
        return NO;
    }
}

#pragma mark - 给表中增加数据
- (BOOL)addNewsListDataWithModelArr:(NSArray<NewsItemModel *> *)modelArr {
    
    for (NewsItemModel *model in modelArr) {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(category, thumbnail_pic_s, title, date, author_name, url, uniquekey) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@');", TABLENAME, model.category, model.thumbnail_pic_s, model.title, model.date, model.author_name, model.url, model.uniquekey];
        BOOL creatSuccess = [[DBManager sharedInstance] execSQL:sql];
        if (!creatSuccess) {
            NSLog(@"addNewsListDataWithModelArr--添加字段失败");
            return NO;
        }
    }
    return YES;
}
@end
