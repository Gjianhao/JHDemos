//
//  NewsTableViewCell.h
//  Demo_Pods
//
//  Created by gjh on 2020/10/28.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsItemModel;

NS_ASSUME_NONNULL_BEGIN

@protocol NewsTableViewCellDeleteBtnDelegate <NSObject>

- (void)tableView:(UITableViewCell *)tableViewCell clickDeleteBtn:(UIButton *)deleteBtn;

@end

@interface NewsTableViewCell : UITableViewCell
// 代替delegate
@property (nonatomic, strong) RACSubject *deleteBtnSignal;

@property (nonatomic, weak) id<NewsTableViewCellDeleteBtnDelegate> deteleBtnDelegate;

- (void)layoutTableViewCell:(NewsItemModel *)itemModel;
@end

NS_ASSUME_NONNULL_END
