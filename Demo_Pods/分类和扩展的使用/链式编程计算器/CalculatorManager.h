//
//  CalculatorManager.h
//  Demo_Pods
//
//  Created by gjh on 2020/12/3.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalculatorManager : NSObject

@property (nonatomic, assign) int result;

- (CalculatorManager *(^)(int))add;

@end

NS_ASSUME_NONNULL_END
