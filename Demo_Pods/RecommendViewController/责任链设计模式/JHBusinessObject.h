//
//  JHBusinessObject.h
//  Demo_Pods
//
//  Created by gjh on 2021/3/23.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class JHBusinessObject;
typedef void(^CompletionBlock)(BOOL handled);
typedef void(^ResultBlock)(JHBusinessObject * _Nullable handler, BOOL handled);

@interface JHBusinessObject : NSObject

/// 下一个响应者（响应链构成的关键）
@property (nonatomic, strong) JHBusinessObject *nextBusiness;

/// 响应者的处理方法
/// @param result result
- (void)handle:(ResultBlock)result;

/// 各个业务在该方法当中做实际业务处理
/// @param completion completion
- (void)handleBusiness:(CompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
