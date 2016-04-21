//
//  Utils.h
//  Categories
//
//  Created by luomeng on 16/4/12.
//  Copyright © 2016年 luomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

/**
 * get top ViewController
 */
+ (UIViewController*)topMostViewController;

// 360 Rotation
+ (void)stopRotateAnimation:(UIView *)view;

+ (void)startRotateAnimation:(UIView *)view;

@end
