//
//  User.h
//  Demo_Pods
//
//  Created by gjh on 2020/11/26.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

- (instancetype)initWithUserID:(NSUInteger)userID;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, assign) NSUInteger userID;
@property (nonatomic, assign) NSUInteger blogCount;
@property (nonatomic, assign) NSUInteger friendCount;



@end

NS_ASSUME_NONNULL_END
