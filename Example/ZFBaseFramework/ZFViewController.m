//
//  ZFViewController.m
//  ZFBaseFramework
//
//  Created by 478043385@qq.com on 01/21/2019.
//  Copyright (c) 2019 478043385@qq.com. All rights reserved.
//

#import "ZFViewController.h"
#import <ZFBaseFramework/ZFDownLoaderManager.h>
#import <ZFBaseFramework/ZFFileManagerTool.h>
@interface ZFViewController ()
{
    NSURL *url;
}
@property(nonatomic, strong)ZFDownLoaderManager *downLoaderManager;
@end

@implementation ZFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    url = [NSURL URLWithString:@"http://audio.xmcdn.com/group23/M06/5C/70/wKgJL1g0DVahoMhrAMJMkvfN17c025.m4a"];
    
    NSLog(@"tmp path :%@",[ZFFileManagerTool tmpPath]);
    NSLog(@"cache path :%@",[ZFFileManagerTool cachePath]);

}

- (ZFDownLoaderManager *)downLoaderManager
{
    if (!_downLoaderManager) {
        _downLoaderManager = [ZFDownLoaderManager shareInstance];
    }
    return _downLoaderManager;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)downLoad:(id)sender {
    
    [self.downLoaderManager downLoadWithURL:url progress:^(long long fileSize, float progress) {
        NSLog(@"下载进度:%f 文件总大小:%lld",progress,fileSize);
    } state:^(ZFDownLoaderState state) {
        NSLog(@"文件下载状态:%lu",(unsigned long)state);
    } success:^(NSString * _Nonnull cachePath) {
        NSLog(@"下载成功------%@",cachePath);
    } fail:^{
        NSLog(@"下载失败---");
    }];
}
- (IBAction)pause:(id)sender {
    [self.downLoaderManager pauseWithURL:url];
}
- (IBAction)resume:(id)sender {
    [self.downLoaderManager resumeWithURL:url];
}
- (IBAction)cancel:(id)sender {
    [self.downLoaderManager cancelWithURL:url];
}
- (IBAction)nextPage:(id)sender {
}

@end
