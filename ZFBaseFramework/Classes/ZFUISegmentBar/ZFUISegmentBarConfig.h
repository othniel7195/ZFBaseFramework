//
//  ZFUISegmentBarConfig.h
//  ZFUISegmentBar
//
//  Created by zf on 2019/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZFUISegmentBarConfig : NSObject

+ (instancetype)defaultConfig;

#pragma mark -- style
/* 背景颜色*/
@property(nonatomic, strong) UIColor *segmentBarBackgroundColor;
/* item normal color*/
@property(nonatomic, strong) UIColor *itemNormalColor;
/* item select color*/
@property(nonatomic, strong) UIColor *itemSelectedColor;
@property(nonatomic, strong) UIFont *itemFont;
/* 指示器color*/
@property(nonatomic, strong) UIColor *indicatorColor;
/* 指示器 height*/
@property(nonatomic, assign) CGFloat indicatorHeight;
/* 指示器 间距*/
@property(nonatomic, assign) CGFloat indicatorSB;

#pragma mark -- 数据源
@property(nonatomic, copy)NSArray <NSString *> *itemDatas;

@end

NS_ASSUME_NONNULL_END
