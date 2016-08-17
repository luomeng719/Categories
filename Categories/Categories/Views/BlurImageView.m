////
////  BlurImageView.m
////  BlurImageView
////
////  Created by luomeng on 16/8/17.
////  Copyright © 2016年 ILS. All rights reserved.
////
//
//#import "BlurImageView.h"
//#import "SDWebImageManager.h"
//
//@import Accelerate;
//
//@interface BlurImageView ()
//@property (nonatomic, strong) id<SDWebImageOperation> imageOperation;
//@end
//
//@implementation BlurImageView
//
//- (void)bo_setImageWithURL:(NSURL *)imgURL placeHolderImage:(UIImage *)placeImage blurRadius:(NSInteger)blurRadius {
//    self.image = placeImage;
//    [self cancelImageLoadingOperation];
//    
//    SDWebImageManager *sdManager = [SDWebImageManager sharedManager];
//    self.imageOperation = [sdManager downloadImageWithURL:imgURL options:SDWebImageProgressiveDownload progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        if (!error && image) {
//            UIImage *blurImage = [image ADKGaussianBlurWithRadius:blurRadius];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.image = blurImage;
//            });
//        }
//    }];
//}
//
//- (void)cancelImageLoadingOperation {
//    [self.imageOperation cancel];
//    self.imageOperation = nil;
//}
//
//- (void)cancelAllOperation {
//    [self cancelImageLoadingOperation];
//}
//
//@end
//
//
//#pragma mark - UIImage (Blur)
//@implementation UIImage (Blur)
//
//- (UIImage *)ADKGaussianBlurWithRadius:(NSInteger)blurRadius {
//    CGRect imageDrawRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
//    
//    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
//    CGContextRef effectInContext = UIGraphicsGetCurrentContext();
//    CGContextScaleCTM(effectInContext, 1.0, -1.0);
//    CGContextTranslateCTM(effectInContext, 0, -self.size.height);
//    CGContextDrawImage(effectInContext, imageDrawRect, self.CGImage);
//    
//    vImage_Buffer effectInBuffer;
//    effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
//    effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
//    effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
//    effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
//    
//    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
//    CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
//    vImage_Buffer effectOutBuffer;
//    effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
//    effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
//    effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
//    effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
//    
//    CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
//    NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
//    if (radius % 2 != 1) {
//        radius += 1;
//    }
//    vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
//    vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
//    vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
//    
//    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    UIGraphicsEndImageContext();
//    
//    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
//    CGContextRef outputContext = UIGraphicsGetCurrentContext();
//    CGContextScaleCTM(outputContext, 1.0, -1.0);
//    CGContextTranslateCTM(outputContext, 0, -self.size.height);
//    
//    CGContextDrawImage(outputContext, imageDrawRect, self.CGImage);
//    
//    CGContextSaveGState(outputContext);
//    CGContextDrawImage(outputContext, imageDrawRect, finalImage.CGImage);
//    CGContextRestoreGState(outputContext);
//    
//    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return outputImage;
//}
//
//@end
