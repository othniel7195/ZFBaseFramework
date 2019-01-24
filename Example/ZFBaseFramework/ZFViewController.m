//
//  ZFViewController.m
//  ZFBaseFramework
//
//  Created by 478043385@qq.com on 01/21/2019.
//  Copyright (c) 2019 478043385@qq.com. All rights reserved.
//

#import "ZFViewController.h"
#import "ZFDownLoader.h"

@interface ZFViewController ()
{
    
}
@property(nonatomic, strong)ZFDownLoader *downLoader;
@end

@implementation ZFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://hkvps.webnoteeditor.com/download/silverUpload.rar"];
    self.downLoader = [[ZFDownLoader alloc] init];
    [self.downLoader downLoadWithURL:url
                   downLoadInfo:^(long long fileSize) {
                       
                   } downLoadSuccess:^(NSString * _Nonnull cachePath) {
                       
                   } downLoadFail:^{
                       
                   }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
