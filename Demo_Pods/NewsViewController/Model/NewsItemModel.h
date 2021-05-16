//
//  NewsItemModel.h
//  Demo_Pods
//
//  Created by gjh on 2020/11/2.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 列表结构化数据
@interface NewsItemModel : NSObject <NSSecureCoding>

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *thumbnail_pic_s;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *author_name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *uniquekey;

+ (__kindof NewsItemModel *)configWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
