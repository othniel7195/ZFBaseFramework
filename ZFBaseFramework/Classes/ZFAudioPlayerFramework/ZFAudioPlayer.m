//
//  ZFAudioPlayer.m
//  ZFBaseFramework
//
//  Created by zhao.feng on 2019/1/25.
//

#import "ZFAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface ZFAudioPlayer ()
@property(nonatomic, strong)AVPlayer *player;
@end

@implementation ZFAudioPlayer

- (void)playWithURL:(NSURL *)url
{
    //AVPlayerItem  「1.资源的请求 2.资源的组织，3.资源的播放」
    
    if (self.player.currentItem) {
        [self clearObserve];
    }
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:NULL];
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
}
//清理observe监听
- (void)clearObserve
{
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey] integerValue];
        
        switch (status) {
            case AVPlayerItemStatusUnknown:
               
                break;
            case AVPlayerItemStatusFailed:
                NSLog(@"数据准备失败");
                break;
            case AVPlayerItemStatusReadyToPlay:
            {
             
                NSLog(@"数据已经准备好");
                [self.player play];
                break;
            }
            default:
                break;
        }
    }
    
}

- (void)pause
{
    [self.player pause];
}
- (void)resume
{
    [self.player play];
}
- (void)stop
{
    [self.player pause];
    self.player = nil;
}
- (void)seekWithTime:(NSTimeInterval)time
{
    // CMTime 影片时间

    // 影片时间 -> 秒
    NSTimeInterval startTime = CMTimeGetSeconds(self.player.currentItem.currentTime);
    double cTime =  startTime + time;
    
     // 秒 -> 影片时间
    //苹果建议600帧，可以兼容各种视频帧率(24fps, 30fps, 25fps等)，是这些帧率的最小公倍数,需要跟精确可以设置更大的
    //为了保证时间精度而设置的帧率，并不一定是视频最后实际的播放帧率
    CMTime playTime = CMTimeMakeWithSeconds(cTime, 600);
    
    [self.player seekToTime:playTime completionHandler:^(BOOL finished) {
        
        if (finished) {
            NSLog(@"确认加载这个时间点的数据");
        }else{
            NSLog(@"取消加载这个时间点的数据");
        }
    }];
}
- (void)setProgress:(float)progress
{
    NSTimeInterval startTime = CMTimeGetSeconds(self.player.currentItem.currentTime);
    double totalTime =  CMTimeGetSeconds(self.player.currentItem.duration);
    double cTime = progress * totalTime;
    [self seekWithTime:cTime - startTime];
}
- (float)progress
{
    NSTimeInterval startTime = CMTimeGetSeconds(self.player.currentItem.currentTime);
    double totalTime =  CMTimeGetSeconds(self.player.currentItem.duration);
    return startTime/totalTime;
}
- (void)setMute:(BOOL)mute
{
    _mute = mute;
    self.player.muted = mute;
}
- (void)setRate:(float)rate
{
    _rate = rate;
    self.player.rate = rate;
}
- (void)setVolume:(float)volume
{
    //如果静音的时候 调整音量  改变静音状态
    if (volume > 0) {
        self.mute = NO;
    }
    _volume = volume;
    self.player.volume = volume;
}

- (void)dealloc
{
    [self clearObserve];
}

@end
