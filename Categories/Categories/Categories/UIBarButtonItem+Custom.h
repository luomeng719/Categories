//
//  UIBarButtonItem+Custom.h
//  Categories
//
//  Created by luomeng on 15/11/3.
//  Copyright © 2015年 luomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Custom)

+ (UIBarButtonItem *)barButtonItemWithNormalImagenName:(NSString *)normalImageName
                                  highlightedImageName:(NSString *)highlightedImageName
                                                target:(id)taget
                                                action:(SEL)action;

+ (UIBarButtonItem *)barButtonItemWithNormalImagenName:(NSString *)normalImageName
                                     selectedImageName:(NSString *)selectedImageName
                                                target:(id)taget
                                                action:(SEL)action;

@end
