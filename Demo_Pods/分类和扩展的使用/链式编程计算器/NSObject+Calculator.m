//
//  NSObject+Calculator.m
//  Demo_Pods
//
//  Created by gjh on 2020/12/3.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "NSObject+Calculator.h"

@implementation NSObject (Calculator)

+ (int)JH_CalculatorMaker:(void (^)(CalculatorManager * _Nonnull))block {
    CalculatorManager *manage = [[CalculatorManager alloc] init];
    block(manage);
    return manage.result;
}
@end
