//
//  JHNetWorkUtil.m
//  Demo_Pods
//
//  Created by gjh on 2020/10/11.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "JHNetWorkUtil.h"
#import "AFNetworking.h"

@implementation JHNetWorkUtil

/// GET 请求
/// @param url <#url description#>
/// @param para <#para description#>
- (void) get:(NSString *)url parameters:(nonnull id)para  {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:para headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"成功");
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败");
        }];
}

// POST 请求
- (void) post:(NSString *)url parameters:(nonnull id)para {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:para headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"成功");
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"失败");
        }];
}

@end
