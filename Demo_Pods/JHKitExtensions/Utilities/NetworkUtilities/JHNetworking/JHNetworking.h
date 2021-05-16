//
//  JHNetworking.h
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/5.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHNetworking : NSObject
/// post请求
+ (NSURLSessionDataTask *)postUrl:(NSString *)urlString parameters:(id)parameters success:(void(^)(NSURLSessionDataTask *task, id responseObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
