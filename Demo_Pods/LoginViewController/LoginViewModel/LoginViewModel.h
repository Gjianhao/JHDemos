//
//  LoginViewModel.h
//  Demo_Pods
//
//  Created by gjh on 2020/12/8.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

@property (nonatomic, strong, readonly) RACSignal *loginEnableSignal;

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end

NS_ASSUME_NONNULL_END
