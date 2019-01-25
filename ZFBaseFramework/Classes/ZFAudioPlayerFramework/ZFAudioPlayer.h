//
//  ZFAudioPlayer.h
//  ZFBaseFramework
//
//  Created by zhao.feng on 2019/1/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZFAudioPlayer : NSObject

- (void)playWithURL:(NSURL *)url;


//暂停
- (void)pause;
//继续
- (void)resume;
//停止
- (void)stop;
//快进 快退
- (void)seekWithTime:(NSTimeInterval)time;
//进度
@property(nonatomic, assign)float progress;
//静音
@property(nonatomic, assign)BOOL mute;
//速率
@property(nonatomic, assign)float rate;
//音量
@property(nonatomic, assign)float volume;

@end

NS_ASSUME_NONNULL_END
