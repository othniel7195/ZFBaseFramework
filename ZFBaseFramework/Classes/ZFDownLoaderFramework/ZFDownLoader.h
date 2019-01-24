//
//  ZFDownLoader.h
//  ZFBaseFramework
//
//  Created by zf on 2019/1/23.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ZFDownLoaderState) {
    //未知
    eZFDownLoaderStateUnknown,
    //暂停
    eZFDownLoaderStatePause,
    //正在下载
    eZFDownLoaderStateDowning,
    //下载成功
    eZFDownLoaderStateSuccess,
    //下载失败
    eZFDownLoaderStateFail,
};

NS_ASSUME_NONNULL_BEGIN
//获取文件下载进度
typedef void(^ZFDownLoadInfo)(long long fileSize,float progress);
//下载成功返回文件路径
typedef void(^ZFDownLoadSuccess)(NSString *cachePath);
//下载失败
typedef void(^ZFDownLoadFail)(void);
//监听状态改变
typedef void(^ZFDownLoadStateChange)(ZFDownLoaderState state);

@interface ZFDownLoader : NSObject

//下载
- (void)downLoadWithURL:(NSURL *)url
           downLoadInfo:(ZFDownLoadInfo)downLoadInfo
       downLoadStateChange:(ZFDownLoadStateChange)stateChange
        downLoadSuccess:(ZFDownLoadSuccess)success
           downLoadFail:(ZFDownLoadFail)fail;

//恢复下载
- (void)resume;
//暂停下载
- (void)pause;
//取消下载
- (void)cancel;
//取消下载并删除缓存
- (void)cancelAndClearCache;
//当前状态
@property(nonatomic, assign, readonly)ZFDownLoaderState state;
//下载进度
@property(nonatomic, assign, readonly)CGFloat progress;

@end

NS_ASSUME_NONNULL_END
