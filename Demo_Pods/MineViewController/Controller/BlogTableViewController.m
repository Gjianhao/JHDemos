//
//  BlogTableViewController.m
//  Demo_Pods
//
//  Created by gjh on 2020/11/26.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "BlogTableViewController.h"
#import "BlogCellHelper.h"

#define RowHeight 44

@interface BlogTableViewController ()

@property (nonatomic, assign) NSUInteger userID;
@property (nonatomic, strong) UserAPIManager *apiManager;
@property (nonatomic, strong) NSMutableArray<BlogCellHelper *> *blogs;
@property (nonatomic, strong) UITableView *tableView;

@end
@implementation BlogTableViewController

+ (instancetype)instanceWithUserID:(NSUInteger)userID {
    return [[BlogTableViewController alloc] initWithUserID:userID];
}

-(instancetype)initWithUserID:(NSUInteger)userID {
    if (self == [super init]) {
        self.userID = userID;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.apiManager = [[UserAPIManager alloc] init];
        
        
    }
    return self;
}

#pragma mark - UITableViewDelegate && DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.blogs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - 接口

- (void)fetchDataWithCompletionHandler:(NetWorkCompleationHandler)completionHandler {
    
}

@end
