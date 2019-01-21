//
//  ZFUISegmentBarConfig.m
//  ZFUISegmentBar
//
//  Created by zf on 2019/1/20.
//

#import "ZFUISegmentBarConfig.h"

@implementation ZFUISegmentBarConfig

+ (instancetype)defaultConfig
{
    ZFUISegmentBarConfig *config = [[ZFUISegmentBarConfig alloc] init];
    config.segmentBarBackgroundColor = [UIColor clearColor];
    config.itemFont = [UIFont systemFontOfSize:15.f];
    config.itemNormalColor = [UIColor lightGrayColor];
    config.itemSelectedColor = [UIColor redColor];
    config.indicatorColor = [UIColor redColor];
    config.indicatorHeight = 4.f;
    config.indicatorSB = 5.f;
    
    return config;
}

@end
