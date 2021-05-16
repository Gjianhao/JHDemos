//
//  NewsListViewModel.m
//  Demo_Pods
//
//  Created by gjh on 2020/11/1.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "NewsListViewModel.h"
#import <AFNetworking.h>
#import "NewsItemModel.h"
#import "NewsListDAL.h"

#import "NSObject+Property.h"

@interface NewsListViewModel ()

@end

@implementation NewsListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadListData];
    }
    return self;
}

/// 通过网络加载新闻页面的数据
- (void)loadListData {
    
    @weakify(self)
    _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 请求API，获取数据
            @strongify(self)
            [self getListDataWithBlock:^(BOOL finish, NSArray<NewsItemModel *> * _Nonnull dataArr) {
                if (finish) {
                    [subscriber sendNext:dataArr];
                    [subscriber sendCompleted];
                }
            }];
            return nil;
        }];
    }];
//    [self getSandBoxPath];
}

/// 网络请求
/// @param block 回调
- (void)getListDataWithBlock:(NewsListViewModelBlock _Nonnull)block {
    // 先显示本地的数据
    NSArray<NewsItemModel *> *listData = [self _readDataFromLoacl];
    if (listData) {
        block(YES,listData.copy);
    }
    NSString *urlString = @"https://static001.geekbang.org/univer/classes/ios_dev/lession/45/toutiao.json";
    
    //    [[AFHTTPSessionManager manager] GET:urlString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
    //        NSLog(@"成功");
    //    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
    //        NSLog(@"失败");
    //    }];
    NSURL *url = [NSURL URLWithString:urlString];
    /* 回调数据可以选择delegate或者block方式 */
    //    __weak typeof(self) weakSelf = self;
    @weakify(self)
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //        __strong typeof(weakSelf) strongSelf = weakSelf;
        
//        [data writeToFile:@"/Users/kevin/Documents/iOS学习/视频/五期/5 - Runtime & Rac & Mvvm/data.plist" atomically:YES];
        @strongify(self)
        NSError *jsonError;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSDictionary *result = (NSDictionary *)[(NSDictionary *)jsonObj objectForKey:@"result"];
        NSArray * dataArr = (NSArray *)[result objectForKey:@"data"];
        
        // 生成model的属性code
//        [NSObject creatPropertyCodeWithDict:dataArr[0]];
        
        NSMutableArray *listItemArr = @[].mutableCopy;
        // 这个是异步获取，会先走下面的代码，
        //        [dataArr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        //            NewsItemModel *model = [NewsItemModel yy_modelWithDictionary:(NSDictionary *)x];
        //            [listItemArr addObject:model];
        //        }];
        
        // RAC的高级用法 array方法：将返回的模型自动添加到数组中
        listItemArr = [[[dataArr.rac_sequence map:^id _Nullable(id  _Nullable value) {
            // value: 集合中的元素
            // id ： 返回的对象就是映射的值
            return [NewsItemModel yy_modelWithDictionary:value];
        }] array] mutableCopy];
        
        //        for (NSDictionary *dic in dataArr) {
        //            NewsItemModel *model = [NewsItemModel yy_modelWithDictionary:dic];
        ////            [model configWithDictionary:dic];
        //            [listItemArr addObject:model];
        //        }
        // 存数据
        [[NewsListDAL sharedInstance] addNewsListDataWithModelArr:listItemArr.copy];
        [self archiveListDataWithArray:listItemArr.copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block(error == nil, listItemArr.copy);
            }
        });
    }];
    [dataTask resume];
}
/// 先从本地读取，占位
- (NSArray<NewsItemModel *> *)_readDataFromLoacl {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *listDataPath = [cachePath stringByAppendingPathComponent:@"JHData/list"];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSData *readListData = [manager contentsAtPath:listDataPath];
    id unarchiveObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class], [NewsItemModel class], nil] fromData:readListData error:nil];
    if ([unarchiveObj isKindOfClass:[NSArray class]] && [unarchiveObj count] > 0) {
        return (NSArray<NewsItemModel *> *)unarchiveObj;
    }
    return nil;
}

- (void)archiveListDataWithArray:(NSArray<NewsItemModel *> *)array {
    
    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArr firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    /* 会自动加上斜线，识别为文件 */
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"JHData"];
    NSError *creatError;
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&creatError];
    
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"list"];
    /* 二进制序列化存储到文件 */
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];

    /* 从路径中读取文件的二进制流 */
    NSData *readListData = [fileManager contentsAtPath:listDataPath];
    /* 反序列化 */
    id unarchivedObj = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[NSArray class],[NewsItemModel class], nil] fromData:readListData error:nil];
    
}

/// 沙盒文件操作
- (void)getSandBoxPath {
    NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [pathArr firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    /* 会自动加上斜线，识别为文件 */
    NSString *dataPath = [cachePath stringByAppendingPathComponent:@"JHData"];
    NSError *creatError;
    [fileManager createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:&creatError];
    
    NSString *listDataPath = [dataPath stringByAppendingPathComponent:@"list"];
    NSData *listData = [@"abc" dataUsingEncoding:NSUTF8StringEncoding];
    [fileManager createFileAtPath:listDataPath contents:listData attributes:nil];
    
//    BOOL isExit = [fileManager fileExistsAtPath:listDataPath];
//    if (isExit) {
//        [fileManager removeItemAtPath:listDataPath error:nil];
//    }
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:listDataPath];
    [fileHandle seekToEndOfFile];
    [fileHandle writeData:[@"def" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [fileHandle synchronizeFile];
    [fileHandle closeFile];
    
    NSLog(@"");
}

@end
