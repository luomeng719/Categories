//
//  UIImage+TintColor.h
//  Categories
//
//  Created by luomeng on 15/11/3.
//  Copyright © 2015年 luomeng. All rights reserved.
//
/**
 * 给图片渲染成指定的tintColor
 */

#import <UIKit/UIKit.h>

@interface UIImage (TintColor)

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

@end
