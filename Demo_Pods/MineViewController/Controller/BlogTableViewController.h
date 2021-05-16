//
//  BlogTableViewController.h
//  Demo_Pods
//
//  Created by gjh on 2020/11/26.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAPIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface BlogTableViewController : NSObject <UITableViewDelegate, UITableViewDataSource>

+ (instancetype)instanceWithUserID:(NSUInteger)userID;

- (UITableView *)tableView;

- (void)fetchDataWithCompletionHandler:(NetWorkCompleationHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
