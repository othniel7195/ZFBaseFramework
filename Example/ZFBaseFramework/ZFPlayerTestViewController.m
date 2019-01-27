//
//  ZFPlayerTestViewController.m
//  ZFBaseFramework_Example
//
//  Created by zhao.feng on 2019/1/25.
//  Copyright © 2019年 478043385@qq.com. All rights reserved.
//

#import "ZFPlayerTestViewController.h"
#import <ZFBaseFramework/ZFAudioPlayer.h>
#import <Realm/Realm.h>

@interface ZFPlayerTestViewController ()
@property (weak, nonatomic) IBOutlet UITextField *showTime;
@property (weak, nonatomic) IBOutlet UIProgressView *playProgress;
@property (nonatomic, strong)ZFAudioPlayer *player;
@property (nonatomic, strong)dispatch_source_t timer;
@property (weak, nonatomic) IBOutlet UISlider *sliderProgress;

@end

@implementation ZFPlayerTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, 0), 0.1 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.playProgress.progress = weakSelf.player.progress;
            weakSelf.sliderProgress.value = weakSelf.player.progress;
        });
        
        
    });
    dispatch_resume(self.timer);
}
- (void)dealloc
{
    dispatch_cancel(self.timer);
}
- (ZFAudioPlayer *)player
{
    if (!_player) {
        _player = [[ZFAudioPlayer alloc] init];
    }
    return _player;
}
- (IBAction)resume:(id)sender {
    [self.player resume];
}

- (IBAction)play:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://audio.xmcdn.com/group23/M04/63/C5/wKgJNFg2qdLCziiYAGQxcTOSBEw402.m4a"];
    [self.player playWithURL:url];
}
- (IBAction)pause:(id)sender {
    [self.player pause];
}
- (IBAction)stop:(id)sender {
    [self.player stop];
}
- (IBAction)mutex:(id)sender {
    self.player.mute = !self.player.mute;
}

- (IBAction)pre:(id)sender {
    [self.player seekWithTime:[self.showTime.text doubleValue]];
}
- (IBAction)back:(id)sender {
    [self.player seekWithTime:-[self.showTime.text doubleValue]];
}
- (IBAction)speed2x:(id)sender {
    self.player.rate = 2.0;
}
- (IBAction)speed4x:(id)sender {
    self.player.rate = 4.0;
}
- (IBAction)volume:(UISlider *)sender {
    self.player.volume = sender.value;
}
- (IBAction)changePlayProgress:(UISlider *)sender {
    self.player.progress = sender.value;
}


@end
