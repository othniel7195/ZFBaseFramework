//
//  ZFUISegmentBar.h
//  ZFUISegmentBar
//
//  Created by zf on 2019/1/20.
//

#import <UIKit/UIKit.h>
#import "ZFUISegmentBarConfig.h"

@class ZFUISegmentBar;

NS_ASSUME_NONNULL_BEGIN

@protocol ZFUISegmentBarDelegate <NSObject>


/**
点击事件回调
 @param segmentBar segmentBar
 @param toIndex 当前点击的index
 @param fromIndex 上一个点击的index
 */
- (void)segmentBar:(ZFUISegmentBar *)segmentBar
  didSelectedIndex:(NSInteger)toIndex
         fromIndex:(NSInteger)fromIndex;

@end

@interface ZFUISegmentBar : UIView

+ (instancetype)segmentBarWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items;

@property(nonatomic, weak) id <ZFUISegmentBarDelegate> delegate;
//数据源
@property(nonatomic, copy, readonly) NSArray <NSString *> *items;
//选中的索引
@property(nonatomic, assign) NSInteger selectedIndex;

- (void)updateSegmentConfig:(void(^)(ZFUISegmentBarConfig *))config;

@end

NS_ASSUME_NONNULL_END
