//
//  NSString+ZFTool.m
//  ZFBaseFramework
//
//  Created by zf on 2019/1/23.
//

#import "NSString+ZFTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ZFTool)
- (NSString *)md5Str
{
    const char *data = self.UTF8String;
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data, (CC_LONG)strlen(data), digest);
    //32位
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        //转16进制不够前面补0
        [result appendFormat:@"%02x",digest[i]];
    }
    
    return result;
}
@end
