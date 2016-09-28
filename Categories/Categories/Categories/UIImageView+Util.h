//
//  UIImageView+Util.h
//  BlurImageView
//
//  Created by luomeng on 16/9/28.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Util)

/**
 * set blur image with imageURL
 */
- (void)blur_setImageWithURL:(NSURL *)imgURL placeHolderImage:(UIImage *)placeImage blurRadius:(NSInteger)blurRadius;

/**
 * image show with fade in animation
 */
- (void)fade_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;


- (void)cancelAllOperation;

@end


@interface UIImage (Blur)
- (UIImage *)ADKGaussianBlurWithRadius:(NSInteger)blurRadius;
@end
