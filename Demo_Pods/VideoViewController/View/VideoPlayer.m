//
//  VideoPlayer.m
//  Demo_Pods
//
//  Created by gjh on 2020/11/8.
//  Copyright © 2020 gjh. All rights reserved.
//

#import "VideoPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoPlayer ()

@property (nonatomic, strong, readwrite) AVPlayerItem *playerItem;
@property (nonatomic, strong, readwrite) AVPlayer *player;
@property (nonatomic, strong, readwrite) AVPlayerLayer *Playlayer;

@end

@implementation VideoPlayer

+ (VideoPlayer *)player {
    static VideoPlayer *videoPlayer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        videoPlayer = [[VideoPlayer alloc] init];
    });
    return videoPlayer;
}

- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView {
    /* 保证每次只有一个播放器在播放，在播放前，先关闭之前的 */
    [self _stopPlay];
    
    NSURL *url = [NSURL URLWithString:videoUrl];
    AVAsset *asset = [AVAsset assetWithURL:url];
    
    _playerItem = [AVPlayerItem playerItemWithAsset:asset];
    /* 添加status的状态监听 */
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
    /* 获取视频的时长 */
    CMTime duration = _playerItem.duration;
//    CGFloat durTime = CMTimeGetSeconds(duration);
    
    _player = [AVPlayer playerWithPlayerItem:_playerItem];
    
    [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        NSLog(@"播放进度：%@", @(CMTimeGetSeconds(time)));
    }];
    
    _Playlayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _Playlayer.frame = attachView.frame;
    [attachView.layer addSublayer:_Playlayer];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_playEndHandle) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        [self.player seekToTime:CMTimeMake(0, 1)];
    }];
    

}

- (void)_stopPlay {
    /* 移除通知和KVO监听 */
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_Playlayer removeFromSuperlayer];
    _player = nil;
    _playerItem = nil;
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

- (void)_playEndHandle {
    [_player seekToTime:CMTimeMake(0, 1)];
}

#pragma MARK - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        if ([(NSNumber *)[change objectForKey:NSKeyValueChangeNewKey] integerValue] == AVPlayerItemStatusReadyToPlay) {
            [_player play];
        } else {
//            NSLog(@"");
        }
    }
    else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSLog(@"缓冲：%@", [change objectForKey:NSKeyValueChangeNewKey]);
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
