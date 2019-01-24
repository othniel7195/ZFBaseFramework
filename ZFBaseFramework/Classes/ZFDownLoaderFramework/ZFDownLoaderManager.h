//
//  ZFDownLoaderManager.h
//  ZFBaseFramework
//
//  Created by zf on 2019/1/24.
//

#import <Foundation/Foundation.h>
#import "ZFDownLoader.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZFDownLoaderManager : NSObject

+ (instancetype)shareInstance;
- (void)downLoadWithURL:(NSURL *)url
               progress:(ZFDownLoadInfo)progress
                  state:(ZFDownLoadStateChange)state
                success:(ZFDownLoadSuccess)success
                   fail:(ZFDownLoadFail)fail;

- (void)pauseWithURL:(NSURL *)url;
- (void)resumeWithURL:(NSURL *)url;
- (void)cancelWithURL:(NSURL *)url;
- (void)pauseAll;
- (void)resumeAll;
- (void)cancelAll;

@end

NS_ASSUME_NONNULL_END
