//
//  JHKVONotifying_Person.m
//  Demo_Pods
//
//  Created by gjh on 2020/12/4.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "JHKVONotifying_Person.h"
#import <objc/message.h>

extern NSString *const observerKey;

@implementation JHKVONotifying_Person

- (void)setName:(NSString *)name {
    [super setName:name];
    
    id observer = objc_getAssociatedObject(self, observerKey);
    
    // 调用回调方法
    [observer observeValueForKeyPath:@"name" ofObject:self change:nil context:nil];
}

- (void)dealloc {
    
}

@end
