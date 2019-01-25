//
//  ZFFileManagerTool.m
//  ZFBaseFramework
//
//  Created by zf on 2019/1/23.
//

#import "ZFFileManagerTool.h"
#import <CoreServices/CoreServices.h>

@implementation ZFFileManagerTool

+ (BOOL)isFileExists:(NSString *)filePath
{
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}
+ (long long)fileTotalSize:(NSString *)filePath
{
    if (![self isFileExists:filePath]) {
        return 0;
    }
    NSError *error;
    NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
    if (!fileInfo || error != nil) {
        return 0;
    }
    long long fileSize = [fileInfo[NSFileSize] longLongValue];
    return fileSize;
}
+ (void)moveFile:(NSString *)fromPath toPath:(NSString *)toPath
{
    if (![self isFileExists:fromPath]) {
        return;
    }
    [[NSFileManager defaultManager] moveItemAtPath:fromPath toPath:toPath error:nil];
}
+ (void)removeFileAtPath:(NSString *)filePath;
{
    if (![self isFileExists:filePath]) {
        return;
    }
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

+ (NSString *)cachePath
{
   return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)tmpPath
{
    return NSTemporaryDirectory();
}
+ (NSString *)contentType:(NSString *)path
{
    NSString *fileExtension = path.pathExtension;
    CFStringRef contentTypeC = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,(__bridge CFStringRef _Nonnull)(fileExtension), NULL);
    NSString *contentType = CFBridgingRelease(contentTypeC);
    return contentType;
}
@end


