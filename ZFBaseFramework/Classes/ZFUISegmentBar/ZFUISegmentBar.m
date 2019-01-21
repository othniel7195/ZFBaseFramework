//
//  ZFUISegmentBar.m
//  ZFUISegmentBar
//
//  Created by zf on 2019/1/20.
//

#import "ZFUISegmentBar.h"
#import "UIView+ZFLayout.h"

@interface ZFUISegmentBar ()
{
    UIButton *_lastSelectedBtn;
}
@property(nonatomic, copy, readwrite) NSArray <NSString *> *items;
@property(nonatomic, strong) ZFUISegmentBarConfig *config;
/* 指示器*/
@property(nonatomic, strong) UIView *indicatorView;
/* 容器视图*/
@property(nonatomic, strong) UIScrollView *contentView;

@property(nonatomic, strong) NSMutableArray <UIButton *> *itemBtns;
@end

@implementation ZFUISegmentBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.backgroundColor = self.config.segmentBarBackgroundColor;
    
    return self;
}

+ (instancetype)segmentBarWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items
{
    ZFUISegmentBar *segmentBar = [[ZFUISegmentBar alloc] initWithFrame:frame];
    segmentBar.items = items;
    
    return segmentBar;
}

- (void)updateSegmentConfig:(void (^)(ZFUISegmentBarConfig * _Nonnull))config
{
    
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (self.itemBtns.count == 0 || selectedIndex < 0 || selectedIndex > self.itemBtns.count - 1) return;
    
    _selectedIndex = selectedIndex;
    UIButton *btn = self.itemBtns[selectedIndex];
    [self btnClick:btn];
}

- (void)setItems:(NSArray<NSString *> *)items
{
    //设置数据源
    _items = items;
    
    //删除添加过的itemBtns
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemBtns = nil;
    
    //根据数据源设置button
    for (NSString *item in items) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = self.itemBtns.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:item forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.config.itemSelectedColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.config.itemFont;
        [self.contentView addSubview:btn];
        [self.itemBtns addObject:btn];
    }
    
    //立即刷新
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark -- 私有方法
- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(segmentBar:didSelectedIndex:fromIndex:)]) {
        [self.delegate segmentBar:self didSelectedIndex:btn.tag fromIndex:_lastSelectedBtn.tag];
    }
    
    _lastSelectedBtn.selected = NO;
    btn.selected = YES;
    _lastSelectedBtn = btn;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorView.width = btn.width + self.config.indicatorSB * 2;
        self.indicatorView.centerX = btn.centerX;
    }];
    
    //btn 滚动到中间
    CGFloat scrollX = btn.centerX - self.contentView.width * 0.5;
    
    //当移动的距离小于0 表示在当前屏幕中间的左侧 那就不需要滚动
    if (scrollX < 0) {
        scrollX = 0;
    }
    
    //当移动到中间的距离超过 把scrollview上最后一个元素显示的距离 那么就移动能把最后一个元素显示的距离
    if(scrollX > self.contentView.contentSize.width - self.contentView.width)
    {
        scrollX = self.contentView.contentSize.width - self.contentView.width;
    }
    
    [self.contentView setContentOffset:CGPointMake(scrollX, 0) animated:YES];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    
    CGFloat totalBtnWidth = 0;
    for (UIButton *btn  in self.itemBtns) {
        [btn sizeToFit];
        totalBtnWidth += btn.width;
    }
    
    CGFloat margin = (self.width - totalBtnWidth) / (self.itemBtns.count + 1);
    
    if (margin < 30.f) {
        margin = 30.f;
    }
    
    CGFloat lastBtnX = 0;
    for (UIButton *btn in self.itemBtns) {
        btn.y = 0;
        btn.x = lastBtnX;
        lastBtnX += btn.width + margin;
    }
    
    self.contentView.contentSize = CGSizeMake(lastBtnX, 0);
    
    if (self.itemBtns.count == 0) return;
    
    UIButton *btn = self.itemBtns[self.selectedIndex];
    self.indicatorView.width = btn.width + self.config.indicatorSB * 2;
    self.indicatorView.y = self.height - self.config.indicatorHeight;
    self.indicatorView.centerX = btn.centerX;
    self.indicatorView.height = self.config.indicatorHeight;
    
}

#pragma mark -- lazy load

- (ZFUISegmentBarConfig *)config
{
    if (!_config) {
        _config = [ZFUISegmentBarConfig defaultConfig];
    }
    return _config;
}

- (NSMutableArray <UIButton *> *)itemBtns
{
    if (!_itemBtns) {
        _itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}
- (UIScrollView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_contentView];
    }
    return _contentView;
}
- (UIView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - self.config.indicatorHeight, 0, 0)];
        _indicatorView.backgroundColor = self.config.indicatorColor;
        [self.contentView addSubview:_indicatorView];
    }
    return _indicatorView;
}
@end
