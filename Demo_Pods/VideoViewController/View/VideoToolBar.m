//
//  VideoToolBar.m
//  Demo_Pods
//
//  Created by gjh on 2020/11/8.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "VideoToolBar.h"
#import <Masonry.h>

@interface VideoToolBar ()

@property (nonatomic, strong, readwrite) UIImageView *avatorImageView;
@property (nonatomic, strong, readwrite) UILabel *nickLabel;

@property (nonatomic, strong, readwrite) UIImageView *commentImageView;
@property (nonatomic, strong, readwrite) UILabel *commentLabel;

@property (nonatomic, strong, readwrite) UIImageView *likeImageView;
@property (nonatomic, strong, readwrite) UILabel *likeLabel;

@property (nonatomic, strong, readwrite) UIImageView *shareImageView;
@property (nonatomic, strong, readwrite) UILabel *shareLabel;


@end

@implementation VideoToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:({
            _avatorImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            _avatorImageView.layer.masksToBounds = YES;
            _avatorImageView.layer.cornerRadius = 15;
            _avatorImageView.translatesAutoresizingMaskIntoConstraints = NO; // 使用自动布局的话，设置为NO
            _avatorImageView;
        })];
        [self addSubview:({
            _nickLabel = [[UILabel alloc] init];
            _nickLabel.font = [UIFont systemFontOfSize:15];
            _nickLabel.textColor = [UIColor lightGrayColor];
            _nickLabel.translatesAutoresizingMaskIntoConstraints = NO;
            _nickLabel;
        })];
        
        [self addSubview:({
            _commentImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            _commentImageView.layer.masksToBounds = YES;
            _commentImageView.layer.cornerRadius = 15;
            _commentImageView.translatesAutoresizingMaskIntoConstraints = NO; // 使用自动布局的话，设置为NO
            _commentImageView;
        })];
        [self addSubview:({
            _commentLabel = [[UILabel alloc] init];
            _commentLabel.font = [UIFont systemFontOfSize:15];
            _commentLabel.textColor = [UIColor lightGrayColor];
            _commentLabel.translatesAutoresizingMaskIntoConstraints = NO;
            _commentLabel;
        })];
        
        [self addSubview:({
            _likeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            _likeImageView.layer.masksToBounds = YES;
            _likeImageView.layer.cornerRadius = 15;
            _likeImageView.translatesAutoresizingMaskIntoConstraints = NO; // 使用自动布局的话，设置为NO
            _likeImageView;
        })];
        [self addSubview:({
            _likeLabel = [[UILabel alloc] init];
            _likeLabel.font = [UIFont systemFontOfSize:15];
            _likeLabel.textColor = [UIColor lightGrayColor];
            _likeLabel.translatesAutoresizingMaskIntoConstraints = NO;
            _likeLabel;
        })];
        
        [self addSubview:({
            _shareImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
            _shareImageView.layer.masksToBounds = YES;
            _shareImageView.layer.cornerRadius = 15;
            _shareImageView.translatesAutoresizingMaskIntoConstraints = NO; // 使用自动布局的话，设置为NO
            _shareImageView.contentMode = UIViewContentModeScaleToFill;
            _shareImageView;
        })];
        [self addSubview:({
            _shareLabel = [[UILabel alloc] init];
            _shareLabel.font = [UIFont systemFontOfSize:15];
            _shareLabel.textColor = [UIColor lightGrayColor];
            _shareLabel.translatesAutoresizingMaskIntoConstraints = NO;
            _shareLabel;
        })];
    }
    return self;
}

- (void)layoutWithModel:(id)model {
    
    _avatorImageView.image = [UIImage imageNamed:@"icon.bundle/icon.png"];
    _nickLabel.text = @"极客时间";
    
    _commentImageView.image = [UIImage imageNamed:@"comment.png"];
    _commentLabel.text = @"100";

    _likeImageView.image = [UIImage imageNamed:@"praise.png"];
    _likeLabel.text = @"25";

    _shareImageView.image = [UIImage imageNamed:@"share.png"];
    _shareLabel.text = @"分享";
    
    [_avatorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatorImageView.mas_right).offset(0);
        make.centerY.equalTo(self);
    }];
    
    [_shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.equalTo(self);
    }];
    [_shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.right.equalTo(_shareLabel.mas_left);
    }];
    
    [_likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_shareImageView.mas_left).offset(-15);
        make.centerY.equalTo(self);
    }];
    [_likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.right.equalTo(_likeLabel.mas_left);
    }];
    
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(_likeImageView.mas_left).offset(-15);
    }];
    [_commentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.right.equalTo(_commentLabel.mas_left);
    }];
    
}

@end
