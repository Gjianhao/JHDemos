//
//  CalculateManager.m
//  Demo_Pods
//
//  Created by gjh on 2020/12/5.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "CalculateManager.h"

@implementation CalculateManager

- (instancetype)calculate:(int (^)(int))block {
    _result = block(_result);
    return self;
}

@end
