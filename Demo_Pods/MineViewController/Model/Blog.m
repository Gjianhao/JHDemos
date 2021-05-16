//
//  Blog.m
//  Demo_Pods
//
//  Created by gjh on 2020/11/28.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "Blog.h"

@implementation Blog

- (instancetype)initWithBlogId:(NSUInteger)blogId {
    self.blogId = blogId;
    self.isLiked = blogId % 2;
    self.likeCount = blogId + 10;
    self.blogTitle = [NSString stringWithFormat:@"blogTitle%ld", blogId];
    self.shareCount = blogId + 8;
    self.blogSummary = [NSString stringWithFormat:@"blogSummary%ld", blogId];
    
    return self;
}

@end
