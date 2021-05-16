//
//  NSObject+JSONExtension.m
//  Demo_Pods
//
//  Created by gjh on 2020/10/20.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "NSObject+JSONExtension.h"
#import <objc/runtime.h>

@implementation NSObject (JSONExtension)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [self init];
    
    if (self) {
        unsigned int count;
        // 获取属性列表
        objc_property_t *propertyList = class_copyPropertyList([self class], &count);
        for (unsigned int i = 0; i < count; i ++) {
            // 获取属性的名字
            const char *propertyName = property_getName(propertyList[i]);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            
            id value = [dictionary valueForKey:name];
            if (value) {
                [self setValue:value forKey:name];
            }
        }
        free(propertyList);
    }
    
    return self;
}

@end
