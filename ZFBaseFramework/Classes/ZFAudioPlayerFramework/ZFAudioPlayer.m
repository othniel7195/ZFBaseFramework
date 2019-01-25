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
        
    }
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
}



@end
