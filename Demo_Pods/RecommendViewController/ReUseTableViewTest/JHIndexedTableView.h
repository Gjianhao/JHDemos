//
//  JHIndexedTableView.h
//  Demo_Pods
//
//  Created by gjh on 2021/3/13.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JHIndexedTableViewDataSource <NSObject>

/// 获取一个 tableview 的字母索引条数据的方法
- (NSArray<NSString *> *)indexTitlesForIndexTableView:(UITableView *)tableView;

@end


@interface JHIndexedTableView : UITableView

@property (nonatomic, weak) id<JHIndexedTableViewDataSource> indexedDataSource;

@end

NS_ASSUME_NONNULL_END
