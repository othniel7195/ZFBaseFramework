//
//  ZFDownLoaderManager.m
//  ZFBaseFramework
//
//  Created by zf on 2019/1/24.
//

#import "ZFDownLoaderManager.h"
#import "NSString+ZFTool.h"

@interface ZFDownLoaderManager ()

@property(nonatomic, strong)NSMutableDictionary <NSString *, ZFDownLoader *> *downLoaderInfos;

@end

@implementation ZFDownLoaderManager

static ZFDownLoaderManager *_instance;

+ (instancetype)shareInstance
{
    
    if (!_instance) {
        _instance = [[self alloc] init];
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (NSMutableDictionary *)downLoaderInfos
{
    if (!_downLoaderInfos) {
        _downLoaderInfos = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _downLoaderInfos;
}

- (void)downLoadWithURL:(NSURL *)url
               progress:(ZFDownLoadInfo)progress
                  state:(ZFDownLoadStateChange)state
                success:(ZFDownLoadSuccess)success
                   fail:(ZFDownLoadFail)fail
{
    NSString *md5Str = [url.absoluteString md5Str];
    ZFDownLoader *downLoader = self.downLoaderInfos[md5Str];
    if (downLoader) {
        [downLoader resume];
        return;
    }
    
    downLoader = [[ZFDownLoader alloc] init];
    [self.downLoaderInfos setValue:downLoader forKey:md5Str];
    
    __weak typeof(self) weakSelf = self;
    [downLoader downLoadWithURL:url downLoadInfo:progress downLoadStateChange:state downLoadSuccess:^(NSString * _Nonnull cachePath) {
        [weakSelf.downLoaderInfos removeObjectForKey:md5Str];
        if (success) {
            success(cachePath);
        }
    } downLoadFail:^{
        [weakSelf.downLoaderInfos removeObjectForKey:md5Str];
        if (fail) {
            fail();
        }
    }];
    return;
}

- (void)pauseWithURL:(NSURL *)url
{
    ZFDownLoader *downLoader = self.downLoaderInfos[[url.absoluteString md5Str]];
    [downLoader pause];
}
- (void)resumeWithURL:(NSURL *)url
{
    ZFDownLoader *downLoader = self.downLoaderInfos[[url.absoluteString md5Str]];
    [downLoader resume];
}
- (void)cancelWithURL:(NSURL *)url
{
    ZFDownLoader *downLoader = self.downLoaderInfos[[url.absoluteString md5Str]];
    [downLoader cancel];
}
- (void)pauseAll
{
    [[self.downLoaderInfos allValues] makeObjectsPerformSelector:@selector(pause)];
}
- (void)resumeAll
{
    [[self.downLoaderInfos allValues] makeObjectsPerformSelector:@selector(resume)];
}
- (void)cancelAll
{
     [[self.downLoaderInfos allValues] makeObjectsPerformSelector:@selector(cancel)];
}


@end
