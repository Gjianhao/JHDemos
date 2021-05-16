//
//  JHStudent.h
//  Demo_Pods
//
//  Created by gjh on 2021/1/20.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JHPerson;

NS_ASSUME_NONNULL_BEGIN

@interface JHStudent : NSObject

@property (nonatomic, strong) JHPerson *jhPerson;
@property (nonatomic, copy) NSString *info;

@end

NS_ASSUME_NONNULL_END
