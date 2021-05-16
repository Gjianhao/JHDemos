//
//  VideoCoverViewCell.m
//  Demo_Pods
//
//  Created by gjh on 2020/11/7.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "VideoCoverViewCell.h"
#import "VideoPlayer.h"
#import "VideoToolBar.h"

@interface VideoCoverViewCell ()


@property (nonatomic, strong, readwrite) UIImageView *coverImage;
@property (nonatomic, strong, readwrite) UIImageView *playButton;
@property (nonatomic, copy, readwrite) NSString *videoUrl;
@property (nonatomic, strong, readwrite) VideoToolBar *toolbar;


@end

@implementation VideoCoverViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - VideoToolBarHeight)];
            _coverImage;
        })];
        
        [_coverImage addSubview:({
            _playButton = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-50)/2, (frame.size.height - VideoToolBarHeight-50)/2, 50, 50)];
            [_playButton setImage:[UIImage imageNamed:@"icon.bundle/video@2x.png"]];
            _playButton;
        })];
        
        [self addSubview:({
            _toolbar = [[VideoToolBar alloc] initWithFrame:CGRectMake(0, _coverImage.bounds.size.height, frame.size.width, VideoToolBarHeight)];
            _toolbar;
        })];
        
        UITapGestureRecognizer *tapGuesterRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapToPlay)];
        [self addGestureRecognizer:tapGuesterRec];
        
    }
    return self;
}

- (void)dealloc {
}

- (void)_tapToPlay {
    
    [[VideoPlayer player] playVideoWithUrl:_videoUrl attachView:_coverImage];
    
//    NSLog(@"");
}

- (void)layoutWithVideoCoverUrl:(NSString *)coverUrl VideoUrl:(NSString *)VideoUrl {
    _coverImage.image = [UIImage imageNamed:coverUrl];
    _videoUrl = VideoUrl;
    [_toolbar layoutWithModel:nil];
}


@end
