//
//  ZFFileManagerTool.h
//  ZFBaseFramework
//
//  Created by zf on 2019/1/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZFFileManagerTool : NSObject

+ (BOOL)isFileExists:(NSString *)filePath;
+ (long long)fileTotalSize:(NSString *)filePath;
+ (void)moveFile:(NSString *)fromPath toPath:(NSString *)toPath;
+ (void)removeFileAtPath:(NSString *)filePath;
+ (NSString *)cachePath;
+ (NSString *)tmpPath;
+ (NSString *)contentType:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
