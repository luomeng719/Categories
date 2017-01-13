//
//  Utils.m
//  Categories
//
//  Created by luomeng on 16/4/12.
//  Copyright © 2016年 luomeng. All rights reserved.
//

#import "Utils.h"
#import <sys/stat.h>
#import <dlfcn.h>

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

+ (BOOL)isJailbroken {
    //#if !(TARGET_IPHONE_SIMULATOR)
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]){
        return YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]){
        return YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"]){
        return YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/usr/sbin/sshd"]){
        return YES;
    }else if([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt"]){
        return YES;
    }
    
    NSError *error;
    NSString *stringToBeWritten = @"This is a test.";
    [stringToBeWritten writeToFile:@"/private/jailbreak.txt" atomically:YES
                          encoding:NSUTF8StringEncoding error:&error];
    if(error==nil){
        //Device is jailbroken
        return YES;
    } else {
        [[NSFileManager defaultManager] removeItemAtPath:@"/private/jailbreak.txt" error:nil];
    }
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]){
        //Device is jailbroken
        return YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"]) {
        
        NSLog(@"Device is jailbroken");
        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/User/Applications/"
                                                                               error:nil];
        NSLog(@"applist = %@",applist);
        
        return YES;
    }
    
    struct stat stat_info;
    if (0 == stat("/Applications/Cydia.app", &stat_info)) {
        return YES;
    }
    
    
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    if (env != NULL) {
        return YES;
    }
    
    //#endif
    //All checks have failed. Most probably, the device is not jailbroken
    return NO;
}


- (NSUInteger)calculate {
    
    // sqlite path (MagicalRecord store path)
    NSURL *sqliteURL = nil;//[NSPersistentStore MR_urlForStoreName:@"MLCDBase.sqlite"];
    NSLog(@"sqliteURL = %@", sqliteURL);
    
    NSUInteger sizeOfData = [[NSData dataWithContentsOfURL:sqliteURL] length];
    NSLog(@"sizeOfDAta in bytes %lu",(unsigned long)sizeOfData);
    
    return sizeOfData;
}


@end
