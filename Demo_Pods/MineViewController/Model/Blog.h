//
//  Blog.h
//  Demo_Pods
//
//  Created by gjh on 2020/11/28.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Blog : NSObject

- (instancetype)initWithBlogId:(NSUInteger)blogId;

@property (copy, nonatomic) NSString *blogTitle;
@property (copy, nonatomic) NSString *blogSummary;
@property (assign, nonatomic) BOOL isLiked;
@property (assign, nonatomic) NSUInteger blogId;
@property (assign, nonatomic) NSUInteger likeCount;
@property (assign, nonatomic) NSUInteger shareCount;

@end

NS_ASSUME_NONNULL_END
