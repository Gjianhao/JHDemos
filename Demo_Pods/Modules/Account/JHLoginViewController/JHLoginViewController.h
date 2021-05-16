//
//  JHLoginViewController.h
//  Demo_Pods
//
//  Created by 郭健豪 on 2021/4/11.
//  Copyright © 2021 gjh. All rights reserved.
//

#import "JHViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JHLoginViewController : JHViewController

@property (nonatomic, copy) void (^loginSuccess)(void);

@end

NS_ASSUME_NONNULL_END
