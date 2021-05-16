//
//  NewsItemModel.m
//  Demo_Pods
//
//  Created by gjh on 2020/11/2.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "NewsItemModel.h"

@implementation NewsItemModel

#pragma MARK - NSSecureCoding
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.category = [coder decodeObjectForKey:@"category"];
        self.thumbnail_pic_s = [coder decodeObjectForKey:@"thumbnail_pic_s"];
        self.title = [coder decodeObjectForKey:@"title"];
        self.date = [coder decodeObjectForKey:@"date"];
        self.author_name = [coder decodeObjectForKey:@"author_name"];
        self.url = [coder decodeObjectForKey:@"url"];
        self.uniquekey = [coder decodeObjectForKey:@"uniquekey"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.category forKey:@"category"];
    [coder encodeObject:self.thumbnail_pic_s forKey:@"thumbnail_pic_s"];
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.date forKey:@"date"];
    [coder encodeObject:self.author_name forKey:@"author_name"];
    [coder encodeObject:self.url forKey:@"url"];
    [coder encodeObject:self.uniquekey forKey:@"uniquekey"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

#pragma MARK - public 方法
/// 字典转模型
/// @param dict 字典
+ (__kindof NewsItemModel *)configWithDictionary:(NSDictionary *)dict {
    /* 需要做类型的详细判断 */
//    self.category = [dict objectForKey:@"category"];
//    self.thumbnail_pic_s = [dict objectForKey:@"thumbnail_pic_s"];
//    self.title = [dict objectForKey:@"title"];
//    self.date = [dict objectForKey:@"date"];
//    self.author_name = [dict objectForKey:@"author_name"];
//    self.url = [dict objectForKey:@"url"];
//    self.uniquekey = [dict objectForKey:@"uniquekey"];
    // KVC
    NewsItemModel *itemModel = [[NewsItemModel alloc] init];
    [itemModel setValuesForKeysWithDictionary:dict];
    return itemModel;
}

// 解决KVC报错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"..."]) {
        _url = value;
    }
    // key : 没有找到key， value没有找到value对应的值
}

@end
