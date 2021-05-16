//
//  NSObject+Calculator.h
//  Demo_Pods
//
//  Created by gjh on 2020/12/3.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Calculator)

+ (int)JH_CalculatorMaker:(void(^)(CalculatorManager *manager))block;

@end

NS_ASSUME_NONNULL_END
