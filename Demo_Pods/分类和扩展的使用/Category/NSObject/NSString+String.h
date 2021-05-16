//
//  NSString+String.h
//  Demo_Pods
//
//  Created by gjh on 2021/1/10.
//  Copyright © 2021 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (String)

+ (id)initWithCString:(const char *)nullTerminatedCString encoding:(NSStringEncoding)encoding;

@end

NS_ASSUME_NONNULL_END
