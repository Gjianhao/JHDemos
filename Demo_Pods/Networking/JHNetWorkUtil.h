//
//  JHNetWorkUtil.h
//  Demo_Pods
//
//  Created by gjh on 2020/10/11.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHNetWorkUtil : NSObject

// GET 请求
- (void) get:(NSString *)url parameters:(nonnull id)para;

// POST 请求
- (void) post:(NSString *)url parameters:(nonnull id)para;

@end

NS_ASSUME_NONNULL_END
