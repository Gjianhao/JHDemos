//
//  JHNetworking.m
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/5.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHNetworking.h"
#import <AFNetworking/AFNetworking.h>
@implementation JHNetworking

+ (NSURLSessionDataTask *)postUrl:(NSString *)urlString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nonnull))success failure:(void (^)(NSURLSessionDataTask * _Nonnull, NSError * _Nonnull))failure {
    [AFJSONResponseSerializer serializer].acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return [manager POST:urlString parameters:parameters headers:nil progress:nil success:success failure:failure];
}

@end
