//
//  JHUserGroup.m
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/1.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHUserGroup.h"

@implementation JHUserGroup

- (id)initWithGroupName:(NSString *)groupName users:(NSMutableArray *)users {
    if (self == [super init]) {
        self.groupName = groupName;
        self.users = users;
    }
    return self;
}

- (NSMutableArray *) users
{
    if (_users == nil) {
        _users = [[NSMutableArray alloc] init];
    }
    return _users;
}

- (NSInteger) count
{
    return self.users.count;
}

- (void)addObject:(id)anObject
{
    [self.users addObject:anObject];
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [self.users objectAtIndex:index];
}

@end
