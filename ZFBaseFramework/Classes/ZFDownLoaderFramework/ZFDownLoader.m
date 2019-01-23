//
//  ZFDownLoader.m
//  ZFBaseFramework
//
//  Created by zf on 2019/1/23.
//

#import "ZFDownLoader.h"
#import "ZFFileManagerTool.h"

@interface ZFDownLoader ()
@property(nonatomic, copy)ZFDownLoadInfo *dloadInfo;
@property(nonatomic, copy)ZFDownLoadSuccess *dloadSuccess;
@property(nonatomic, copy)ZFDownLoadFail *dlFail;
@end

@implementation ZFDownLoader

- (void)downLoadWithURL:(NSURL *)url downLoadInfo:(ZFDownLoadInfo)downLoadInfo downLoadSuccess:(ZFDownLoadSuccess)success downLoadFail:(ZFDownLoadFail)fail
{
    self.dloadInfo = downLoadInfo;
    self.dloadSuccess = success;
    self.dlFail = fail;
    [self downLoadWithURL:url];
}

- (void)downLoadWithURL:(NSURL *)url
{
    
}
@end
