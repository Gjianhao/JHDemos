//
//  NewsListViewModel.h
//  Demo_Pods
//
//  Created by gjh on 2020/11/1.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsItemModel;
NS_ASSUME_NONNULL_BEGIN

typedef void(^NewsListViewModelBlock)(BOOL finish, NSArray<NewsItemModel *> *dataArr);

@interface NewsListViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *command;

//- (void)loadListData;

@end

NS_ASSUME_NONNULL_END
