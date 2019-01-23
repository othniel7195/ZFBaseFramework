//
//  ZFDownLoader.m
//  ZFBaseFramework
//
//  Created by zf on 2019/1/23.
//

#import "ZFDownLoader.h"
#import "ZFFileManagerTool.h"
#import "NSString+ZFTool.h"

@interface ZFDownLoader ()
{
    CGFloat _tmpSize;
    CGFloat _cacheSize;
}
@property(nonatomic, copy)ZFDownLoadInfo dloadInfo;
@property(nonatomic, copy)ZFDownLoadSuccess dloadSuccess;
@property(nonatomic, copy)ZFDownLoadFail dlFail;
@property(nonatomic, copy)NSString *downLoadCachePath;
@property(nonatomic, copy)NSString *downLoadTmpPath;

@property(nonatomic, strong)NSURLSession *session;
@property(nonatomic, strong)NSOutputStream *outputSream;
//session强引用  session 和task 1：1  
@property(nonatomic, weak) NSURLSessionTask *task;
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
    // 1. 下载文件的存储
    //    下载中 -> tmp + (url + MD5)
    //    下载完成 -> cache + url.lastCompent
    self.downLoadCachePath = [[ZFFileManagerTool cachePath] stringByAppendingPathComponent:url.lastPathComponent];
    self.downLoadTmpPath = [[ZFFileManagerTool tmpPath] stringByAppendingPathComponent:[url.absoluteString md5Str]];
    
    // 1 首先, 判断, 本地有没有已经下载好, 已经下载完毕, 就直接返回
    // 文件的位置, 文件的大小
    if ([ZFFileManagerTool isFileExists:self.downLoadCachePath]) {
        if (self.dloadInfo) {
            self.dloadInfo([ZFFileManagerTool fileTotalSize:self.downLoadCachePath]);
        }
        self.state = eZFDownLoaderStateSuccess;
        if (self.dloadSuccess) {
            self.dloadSuccess(self.downLoadCachePath);
        }
        
        return;
    }
    
    // 如果任务存在
    if ([url isEqual:self.task.originalRequest.URL]) {
        
        //正在下载就返回
        if (self.state == eZFDownLoaderStateDowning) {
            return;
        }
        
        //暂停就恢复
        if(self.state == eZFDownLoaderStatePause){
            [self resume];
            return;
        }
    }
    
    //如果任务不存在 开启下载
    [self cancel];
    
    //读取本地缓存的大小
    _tmpSize = [ZFFileManagerTool fileTotalSize:self.downLoadTmpPath];
    
    [self downLoadWithURL:url offset:_tmpSize];
}

- (void)downLoadWithURL:(NSURL *)url offset:(CGFloat)offset
{
    
}

- (void)resume
{
    if (self.state == eZFDownLoaderStatePause) {
        [self.task resume];
        self.state = eZFDownLoaderStateDowning;
    }
}
- (void)pause
{
    if (self.state == eZFDownLoaderStateDowning) {
        [self.task suspend];
        self.state = eZFDownLoaderStatePause;
    }
}
- (void)cancel
{
    [self.session invalidateAndCancel];
    self.session = nil;
    self.state = eZFDownLoaderStateCancel;
}
- (void)cancelAndClearCache
{
    [self cancel];
    [ZFFileManagerTool removeFileAtPath:self.downLoadCachePath];
}

- (void)setState:(ZFDownLoaderState)state
{
    _state = state;
}
@end
