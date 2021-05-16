//
//  VideoPlayer.h
//  Demo_Pods
//
//  Created by gjh on 2020/11/8.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayer : NSObject

+ (VideoPlayer *)player;

- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView;

@end

NS_ASSUME_NONNULL_END
