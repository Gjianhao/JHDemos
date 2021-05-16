//
//  JHBusinessObject.m
//  Demo_Pods
//
//  Created by gjh on 2021/3/23.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHBusinessObject.h"

@implementation JHBusinessObject

- (void)handle:(ResultBlock)result {
    CompletionBlock completion = ^(BOOL handled) {
        // 当前业务处理掉了，上抛结果
        if (handled) {
            result(self, handled);
        } else {
            // 沿着责任链， 指派给下一个业务处理
            if (self.nextBusiness) {
                [self.nextBusiness handle:result];
            } else {
                result(nil, NO);
            }
        }
    };
    
    // 当前业务进行处理
    [self handleBusiness:completion];
}

- (void)handleBusiness:(CompletionBlock)completion {
    /// 业务逻辑处理
    /// 如网络请求，本地照片查询
}

@end
