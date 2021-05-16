//
//  User.m
//  Demo_Pods
//
//  Created by gjh on 2020/11/26.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithUserID:(NSUInteger)userID {
    self.name = [NSString stringWithFormat:@"user%lu", userID];
    self.icon = [NSString stringWithFormat:@"icon%lu.png", userID % 2];
    self.userID = userID;
    self.summary = [NSString stringWithFormat:@"userSummary%ld", userID];
    self.blogCount = userID + 8;
    self.friendCount = userID + 10;    
    
    return self;
}

@end
