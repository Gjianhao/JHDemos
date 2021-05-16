//
//  Person.h
//  Demo_Pods
//
//  Created by gjh on 2020/10/12.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

- (instancetype)initWithPersonName:(NSString *)name sex:(NSString *)sex age:(NSInteger)age;

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;

@end

NS_ASSUME_NONNULL_END
