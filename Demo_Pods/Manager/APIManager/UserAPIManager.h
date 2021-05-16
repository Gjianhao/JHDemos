//
//  UserAPIManager.h
//  Demo_Pods
//
//  Created by gjh on 2020/11/26.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NetWorkCompleationHandler)(NSError * _Nullable error, id _Nullable result);
typedef UIViewController *_Nonnull(^ViewControllerGenerator)(id _Nullable params);

typedef enum : NSUInteger {
    NetworkErrorNoData,
    NetworkErrorNoMoreData
} NetworkError;

NS_ASSUME_NONNULL_BEGIN

@interface UserAPIManager : NSObject

//- (void)fetchUserInfoWithUserId:(NSUInteger)userID completionHandler:(NetWorkCompleationHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
