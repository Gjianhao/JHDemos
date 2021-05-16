//
//  JHUserChatSetting.h
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/1.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHUserChatSetting : NSObject

@property (nonatomic, strong) NSString *userID;

@property (nonatomic, assign) BOOL top;

@property (nonatomic, assign) BOOL noDisturb;

@property (nonatomic, strong) NSString *chatBGPath;

@end

NS_ASSUME_NONNULL_END
