//
//  CalculateManager.h
//  Demo_Pods
//
//  Created by gjh on 2020/12/5.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalculateManager : NSObject

@property (nonatomic, assign) int result;

- (instancetype)calculate:(int(^)(int result))block;

@end

NS_ASSUME_NONNULL_END
