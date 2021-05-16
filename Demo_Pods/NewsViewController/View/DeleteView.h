//
//  DeleteView.h
//  Demo_Pods
//
//  Created by gjh on 2020/10/26.
//  Copyright © 2020 gjh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeleteView : UIView

- (void)showDeleteBtnViewFromPoint:(CGPoint)point clickBolck:(dispatch_block_t)clickBlock;

@end

NS_ASSUME_NONNULL_END
