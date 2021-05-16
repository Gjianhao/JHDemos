//
//  JHUserGroup.h
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/1.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHUserGroup : NSObject

/// tag
@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, strong) NSString *groupName;

@property (nonatomic, strong) NSMutableArray *users;

@property (nonatomic, assign, readonly) NSInteger count;

- (id)initWithGroupName:(NSString *)groupName users:(NSMutableArray *)users;

- (void)addObject:(id)anObject;

- (id)objectAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
