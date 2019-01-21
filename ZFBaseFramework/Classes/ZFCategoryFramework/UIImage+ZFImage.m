//
//  UIImage+ZFImage.m
//
//  Created by zf on 2019/1/18.
//  Copyright © 2019 zf. All rights reserved.
//

#import "UIImage+ZFImage.h"

@implementation UIImage (ZFImage)
+ (UIImage *)originImageWithName:(NSString *)name
{
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)circleImage
{
    CGSize size = self.size;
    
    CGFloat drawWH = size.width < size.height? size.width :size.height;
    
    UIGraphicsBeginImageContext(CGSizeMake(drawWH, drawWH));
    //绘制一个圆形区域, 进行裁剪
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect clipRect = CGRectMake(0, 0, drawWH, drawWH);
    CGContextAddEllipseInRect(context, clipRect);
    CGContextClip(context);
    
    CGRect drawRect = CGRectMake(0, 0, size.width, size.height);
    [self drawInRect:drawRect];

    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    
    return resultImage;
}
@end
