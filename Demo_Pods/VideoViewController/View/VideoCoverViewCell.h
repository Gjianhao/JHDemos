//
//  VideoCoverViewCell.h
//  Demo_Pods
//
//  Created by gjh on 2020/11/7.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoCoverViewCell : UICollectionViewCell

- (void)layoutWithVideoCoverUrl:(NSString *)coverUrl VideoUrl:(NSString *)VideoUrl;

@end

NS_ASSUME_NONNULL_END
