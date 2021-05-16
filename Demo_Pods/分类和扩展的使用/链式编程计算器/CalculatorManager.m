//
//  CalculatorManager.m
//  Demo_Pods
//
//  Created by gjh on 2020/12/3.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "CalculatorManager.h"

@implementation CalculatorManager

- (CalculatorManager * _Nonnull (^)(int))add {
    return ^(int value) {
        self.result += value;
        return self;
    };
}

@end
