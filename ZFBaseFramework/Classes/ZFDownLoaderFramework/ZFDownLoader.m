//
//  ZFDownLoader.m
//  ZFBaseFramework
//
//  Created by zf on 2019/1/23.
//

#import "ZFDownLoader.h"
#import "ZFFileManagerTool.h"
#import "NSString+ZFTool.h"

@interface ZFDownLoader ()<NSURLSessionDataDelegate>
{
    long long _tmpSize;
    long long _totalSize;
}
@property(nonatomic, copy)ZFDownLoadInfo dloadInfo;
@property(nonatomic, copy)ZFDownLoadSuccess dloadSuccess;
@property(nonatomic, copy)ZFDownLoadFail dlFail;
@property(nonatomic, copy)NSString *downLoadCachePath;
@property(nonatomic, copy)NSString *downLoadTmpPath;

@property(nonatomic, strong)NSURLSession *session;
@property(nonatomic, strong)NSOutputStream *outputSream;
//session强引用  session 和task 1：1  
@property(nonatomic, weak) NSURLSessionDataTask *task;
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

- (void)downLoadWithURL:(NSURL *)url offset:(long long)offset
{
    //创建请求信息
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:0];
    [request setValue:[NSString stringWithFormat:@"btyes=%lld-",offset] forHTTPHeaderField:@"Range"];
    
    //发起请求
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
    self.task = task;
    [self.task resume];
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

- (NSURLSession *)session
{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

#pragma mark -- NSURLSession Delegate

//当发生请求时第一次接到响应的回调，内部处理后续的数据处理
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    _totalSize = [httpResponse.allHeaderFields[@"Content-Length"] longLongValue];
    
    //Content-Range: bytes (unit first byte pos) - [last byte pos]/[entity legth]
    if (httpResponse.allHeaderFields[@"Content-Range"]) {
     _totalSize = [[[httpResponse.allHeaderFields[@"Content-Range"] componentsSeparatedByString:@"/"] lastObject] longLongValue];
    }
    
    if (self.dloadInfo) {
        self.dloadInfo(_totalSize);
    }
    
    //下载完成
    if (_tmpSize == _totalSize) {
        //文件移动到cache
        [ZFFileManagerTool moveFile:self.downLoadTmpPath toPath:self.downLoadCachePath];
        
        self.state = eZFDownLoaderStateSuccess;
        //结束请求
        completionHandler(NSURLSessionResponseCancel);
        
        return;
    }
    
    //下载有问题
    if (_tmpSize > _totalSize) {
        //清空临时缓存
        [ZFFileManagerTool removeFileAtPath:self.downLoadTmpPath];
        //取消请求
        completionHandler(NSURLSessionResponseCancel);
        //重新下载
        [self downLoadWithURL:response.URL offset:0];
        
        return;
    }
    
    
    
    completionHandler(NSURLSessionResponseAllow);
    
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
{
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        disposition = NSURLSessionAuthChallengeUseCredential;
    } else {
        if (challenge.previousFailureCount == 0) {
            disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
        } else {
            disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
        }
    }
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}
@end
