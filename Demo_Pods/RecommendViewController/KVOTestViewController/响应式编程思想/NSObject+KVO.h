//
//  NSObject+KVO.h
//  Demo_Pods
//
//  Created by gjh on 2020/12/4.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KVO)

- (void)jh_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end

NS_ASSUME_NONNULL_END
