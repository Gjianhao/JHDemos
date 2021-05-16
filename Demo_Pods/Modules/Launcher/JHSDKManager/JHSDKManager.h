//
//  JHSDKManager.h
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/1.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHSDKManager : NSObject

+ (JHSDKManager *)sharedInstance;

- (void)launchInWindow:(UIWindow *)window;

@end

NS_ASSUME_NONNULL_END
