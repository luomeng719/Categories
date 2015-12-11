//
//  UIImage+Utils.h
//  Categories
//
//  Created by luomeng on 15/11/3.
//  Copyright © 2015年 luomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>

typedef NS_ENUM(NSInteger, GradientdDirection) {
    Horizontal,
    Vertical,
    ForwardSlash,
    BackSlash
};

@interface UIImage (Utils)

/**
 *  创建纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color withRadius:(float)radius;
+ (UIImage *)imageWithColor:(UIColor *)color withEdgeLength:(NSUInteger)edgeLength;

/*! 渐变 */
+ (UIImage *)imageWithColors:(NSArray *)colors
                   imageSize:(CGSize)size
           gradientDirection:(GradientdDirection)direction;

- (UIImage *)imageTintedWithColor:(UIColor *)color;
- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;

/*! 模糊图片 */
- (UIImage*)blurredImage:(CGFloat)blurAmount;

/*! 图片应用alpha */
- (UIImage *)imageByApplyingAlpha:(float)alpha;

/*! 修复UIImagePickerController采集后是图片被旋转90度问题 */
- (UIImage *)fixOrientation;

/** tabbar 获取原图片，否则蓝色*/
+ (UIImage *)originalImageNamed:(NSString *)name;

/** 
 * 在给定区域内等比例缩放图片
 */
- (UIImage*)scaleToSize:(CGSize)size;
@end
