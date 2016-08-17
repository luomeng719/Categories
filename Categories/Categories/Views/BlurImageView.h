//
//  BlurImageView.h
//  BlurImageView
//
//  Created by luomeng on 16/8/17.
//  Copyright © 2016年 ILS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlurImageView : UIImageView

- (void)bo_setImageWithURL:(NSURL *)imgURL placeHolderImage:(UIImage *)placeImage blurRadius:(NSInteger)blurRadius;

- (void)cancelAllOperation;

@end


@interface UIImage (Blur)
- (UIImage *)ADKGaussianBlurWithRadius:(NSInteger)blurRadius;
@end
