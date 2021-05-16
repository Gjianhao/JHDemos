//
//  NewsTableViewCell.m
//  Demo_Pods
//
//  Created by gjh on 2020/10/28.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NewsItemModel.h"
#import <SDWebImage.h>

@interface NewsTableViewCell ()

@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *sourceLabel;
@property (nonatomic, strong, readwrite) UILabel *commentLabel;
@property (nonatomic, strong, readwrite) UILabel *timeLabel;
@property (nonatomic, strong, readwrite) UIImageView *rightImageView;
@property (nonatomic, strong, readwrite) UIButton *deleteBtn;

@end

@implementation NewsTableViewCell

- (RACSubject *)deleteBtnSignal {
    if (_deleteBtnSignal == nil) {
        _deleteBtnSignal = [[RACSubject alloc] init];
    }
    return _deleteBtnSignal;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:({
            self.titleLabel = [[UILabel alloc] initWithFrame:UIRect(20, 15, SCREEN_WIDTH-120, 50)];
            self.titleLabel.font = [UIFont systemFontOfSize:16];
            self.titleLabel.textColor = [UIColor blackColor];
            self.titleLabel.numberOfLines = 2;
            self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            self.titleLabel;
        })];
        
        [self.contentView addSubview:({
            self.sourceLabel = [[UILabel alloc] initWithFrame:UIRect(20, 80, 50, 20)];
            self.sourceLabel.font = [UIFont systemFontOfSize:12];
            self.sourceLabel.textColor = [UIColor grayColor];
            self.sourceLabel;
        })];
                
        [self.contentView addSubview:({
            self.commentLabel = [[UILabel alloc] initWithFrame:UIRect(100, 80, 50, 20)];
            self.commentLabel.font = [UIFont systemFontOfSize:12];
            self.commentLabel.textColor = [UIColor grayColor];
            self.commentLabel;
        })];
        
        [self.contentView addSubview:({
            self.timeLabel = [[UILabel alloc] initWithFrame:UIRect(150, 80, 50, 20)];
            self.timeLabel.font = [UIFont systemFontOfSize:12];
            self.timeLabel.textColor = [UIColor grayColor];
            self.timeLabel;
        })];
        
        [self.contentView addSubview:({
            self.rightImageView = [[UIImageView alloc] initWithFrame:UIRect(SCREEN_WIDTH-80, 15, 70, 70)];
            self.rightImageView.contentMode = UIViewContentModeScaleAspectFit;
            self.rightImageView;
        })];
        
        [self.contentView addSubview:({
            self.deleteBtn = [[UIButton alloc] initWithFrame:UIRect(0, 75, 20, 20)];
//            self.deleteBtn.backgroundColor = [UIColor grayColor];
            [self.deleteBtn setTitle:@"x" forState:UIControlStateNormal];
            [self.deleteBtn setTitle:@"v" forState:UIControlStateHighlighted];
            [self.deleteBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//            [self.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            // 用rac监听按钮的点击事件
//            LRWeakSelf(self)
            @weakify(self)
            [[self.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//                __strong typeof(weakself) strongSelf = weakself;
                @strongify(self)
                NSLog(@"删除按钮点击");
                    if (self.deteleBtnDelegate && [self.deteleBtnDelegate respondsToSelector:@selector(tableView:clickDeleteBtn:)]) {
                        [self.deteleBtnDelegate tableView:self clickDeleteBtn:self.deleteBtn];
                    }
                    // 通知控制器处理
//                    [self.deleteBtnSignal sendNext:self];
            }];
            self.deleteBtn;
        })];
    }
    return self;
}

- (void)layoutTableViewCell:(NewsItemModel *)itemModel {
    
    /* 判断是否是已读 */
    BOOL isHadRead = [[NSUserDefaults standardUserDefaults] boolForKey:itemModel.uniquekey];
    if (isHadRead) {
        self.titleLabel.textColor = [UIColor lightGrayColor];
    } else {
        self.titleLabel.textColor = [UIColor blackColor];
    }
    self.titleLabel.text = itemModel.title;
    
    self.sourceLabel.text = itemModel.author_name;
    [self.sourceLabel sizeToFit];
    
    self.commentLabel.text = itemModel.category;
    [self.commentLabel sizeToFit];
    self.commentLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x + self.sourceLabel.frame.size.width + UI(15), self.commentLabel.frame.origin.y, self.commentLabel.frame.size.width, self.commentLabel.frame.size.height);
    
    self.timeLabel.text = itemModel.date;
    [self.timeLabel sizeToFit];
    self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x + self.commentLabel.frame.size.width + UI(15), self.timeLabel.frame.origin.y, self.timeLabel.frame.size.width, self.timeLabel.frame.size.height);
    
    /* 图片的加载放到子线程 */
//    __block UIImage *img = nil;
//    NSThread *downloadImageThread = [[NSThread alloc] initWithBlock:^{
//        img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:itemModel.thumbnail_pic_s]]];
//    }];
//    downloadImageThread.name = @"downloadImageThread";
//    [downloadImageThread start];
//    self.rightImageView.image = img;
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:itemModel.thumbnail_pic_s]]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.rightImageView.image = img;
//        });
//    });
    
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:itemModel.thumbnail_pic_s] placeholderImage:[UIImage imageNamed:@"icon.budle/icon.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        NSLog(@"");
    }];
    
    self.deleteBtn.frame = CGRectMake(self.timeLabel.frame.origin.x + self.timeLabel.frame.size.width + UI(15), self.deleteBtn.frame.origin.y, self.deleteBtn.frame.size.width, self.deleteBtn.frame.size.height);
}

- (void)deleteBtnClick:(UIButton *)sender {
//    if (self.deteleBtnDelegate && [self.deteleBtnDelegate respondsToSelector:@selector(tableView:clickDeleteBtn:)]) {
//        [self.deteleBtnDelegate tableView:self clickDeleteBtn:self.deleteBtn];
//    }
    // 通知控制器处理
    [self.deleteBtnSignal sendNext:self];
}

@end
