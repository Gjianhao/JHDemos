//
//  JHCoreDataTestViewController.m
//  Demo_Pods
//
//  Created by gjh on 2021/1/20.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHCoreDataTestViewController.h"
#import <CoreData/CoreData.h>
#import "Employee+CoreDataProperties.h"

@interface JHCoreDataTestViewController ()
@property (nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation JHCoreDataTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self coreData];
    
}
#pragma mark - 添加按钮的监听事件
- (void)addMemberClick {
    // 创建员工
    Employee *employee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.context];
    employee.name = @"zhangsan";
    employee.height = 180;
    employee.birthday = [NSDate date];
    NSError *error = nil;
    [self.context save:&error];
    if (!error) {
        NSLog(@"success");
    } else {
        NSLog(@"%@", error);
    }
}
#pragma mark - coreData 的实现方法
- (void)coreData {
    // 1.上下文关联模型文件
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    // 关联模型文件
    
    // 创建一个模型对象
    // 传一个 nil 会把bundle 下所有模型文件关联起来
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    // 持久化存储调度器
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 存储数据库的名字
    // 获取 document 目录
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 数据库路径+名称
    NSString *sqlPath = [path stringByAppendingPathComponent:@"coredata.sqlite"];
    NSError *error = nil;
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlPath] options:nil error:&error];
    
    context.persistentStoreCoordinator = coordinator;
    self.context = context;
}
@end
