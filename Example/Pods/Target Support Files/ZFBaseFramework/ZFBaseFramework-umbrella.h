#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CALayer+ZFPauseAimate.h"
#import "NSString+ZFTool.h"
#import "UIImage+ZFImage.h"
#import "UIView+ZFLayout.h"
#import "ZFDownLoader.h"
#import "ZFDeviceInfo.h"
#import "ZFFileManagerTool.h"
#import "ZFUISegmentBar.h"
#import "ZFUISegmentBarConfig.h"

FOUNDATION_EXPORT double ZFBaseFrameworkVersionNumber;
FOUNDATION_EXPORT const unsigned char ZFBaseFrameworkVersionString[];

