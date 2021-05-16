//
//  NSObject+Property.m
//  Demo_Pods
//
//  Created by gjh on 2020/12/9.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "NSObject+Property.h"

@implementation NSObject (Property)

+ (void)creatPropertyCodeWithDict:(NSDictionary *)dict {
    // @property (nonatomic, copy) NSString *name;
    
    NSMutableString *strM = [NSMutableString string];
    // 遍历字典
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        NSLog(@"%@",[obj class]);
        NSString *codeReault;
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFString")]) {
            codeReault = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@;", key];
        } else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]) {
            codeReault = [NSString stringWithFormat:@"@property (nonatomic, assign) NSUInteger *%@;", key];
        } else if ([obj isKindOfClass:NSClassFromString(@"__NSCFArray")]) {
            codeReault = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;", key];
        } else if ([obj isKindOfClass:NSClassFromString(@"__NSCFDictionary")]) {
            codeReault = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@;", key];
        } else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]) {
            codeReault = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;", key];
        }
        [strM appendFormat:@"\n%@", codeReault];
    }];
    NSLog(@"%@",strM);

}

@end
