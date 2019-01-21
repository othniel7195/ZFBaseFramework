//
//  UIView+ZFLayout.m
//
//  Created by zf on 2019/1/16.
//  Copyright © 2019 zf. All rights reserved.
//

#import "UIView+ZFLayout.h"

@implementation UIView (ZFLayout)

- (void)setX:(CGFloat)x
{
    CGRect tmp = self.frame;
    tmp.origin.x = x;
    self.frame = tmp;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect tmp = self.frame;
    tmp.origin.y = y;
    self.frame = tmp;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect tmp = self.frame;
    tmp.size.width = width;
    self.frame = tmp;
}

- (CGFloat)width
{
    return self.frame.size.width;
}


- (void)setHeight:(CGFloat)height
{
    CGRect tmp = self.frame;
    tmp.size.height = height;
    self.frame = tmp;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setX_right:(CGFloat)x_right
{
    CGRect tmp = self.frame;
    tmp.origin.x = x_right - tmp.size.width;
    self.frame = tmp;
}
- (CGFloat)x_right
{
    return self.frame.size.width + self.frame.origin.x;
}

- (void)setY_bottom:(CGFloat)y_bottom
{
    CGRect tmp = self.frame;
    tmp.origin.y = y_bottom - tmp.size.height;
    self.frame = tmp;
}

- (CGFloat)y_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint tmp = self.center;
    tmp.x = centerX;
    self.center = tmp;
}
- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint tmp = self.center;
    tmp.y = centerY;
    self.center = tmp;
}
- (CGFloat)centerY
{
    return self.center.y;
}
@end
