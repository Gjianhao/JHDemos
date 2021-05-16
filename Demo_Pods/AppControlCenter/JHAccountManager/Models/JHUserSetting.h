//
//  JHUserSetting.h
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/1.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHUserSetting : NSObject

@property (nonatomic, strong) NSString *userID;

@property (nonatomic, assign) BOOL star;

@property (nonatomic, assign) BOOL dismissTimeLine;

@property (nonatomic, assign) BOOL prohibitTimeLine;

@property (nonatomic, assign) BOOL blackList;

@end

NS_ASSUME_NONNULL_END
