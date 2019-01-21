//
//  UIImage+ZFImage.h
//
//  Created by zf on 2019/1/18.
//  Copyright © 2019 zf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZFImage)
+ (UIImage *)originImageWithName:(NSString *)name;

- (UIImage *)circleImage;
@end

NS_ASSUME_NONNULL_END
