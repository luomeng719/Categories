//
//  Utils.m
//  Categories
//
//  Created by luomeng on 16/4/12.
//  Copyright © 2016年 luomeng. All rights reserved.
//

#import "Utils.h"

@implementation Utils


+ (UIViewController*)topMostViewController {
    return [[self class] topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [[self class] topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [[self class] topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController && !rootViewController.presentedViewController.isBeingDismissed) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [[self class] topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

+ (void)stopRotateAnimation:(UIView *)view {
    [view.layer removeAllAnimations];
}

+ (void)startRotateAnimation:(UIView *)view {
    [view.layer removeAllAnimations];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(.5*M_PI, 0, 0, 1.0)];
    animation.duration = .25;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 10000;
    [view.layer addAnimation:animation forKey:@"viewRotate"];
}

@end