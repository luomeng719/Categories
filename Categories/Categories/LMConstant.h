//
//  LMConstant.h
//  Categories
//
//  Created by luomeng on 15/11/19.
//  Copyright © 2015年 luomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

// Device
#define is_iPhone4_4s (CGSizeEqualToSize(CGSizeMake(320, 480), [UIScreen mainScreen].bounds.size) ? YES : NO)
#define is_iPhone5_5s (CGSizeEqualToSize(CGSizeMake(320, 568), [UIScreen mainScreen].bounds.size) ? YES : NO)
#define is_iPhone6_6s (CGSizeEqualToSize(CGSizeMake(375, 667), [UIScreen mainScreen].bounds.size) ? YES : NO)
#define is_iPhone6Plus_6sP ([[UIScreen mainScreen] bounds].size.height == 736.0f || [[UIScreen mainScreen] bounds].size.width == 736.0f)
#define is_iPad ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) ? YES : NO

#define AdaptIPad_IPhone4_5_6_6PLUS(iPad,iPhone4,iPhone5,iPhone6,iPhone6Plus) ({ \
CGFloat temp = 0;\
if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) { \
temp =iPad;\
}\
else if(is_iPhone4_4s){\
temp = iPhone4;\
}else if(is_iPhone5_5s){\
temp = iPhone5;\
}\
else if(is_iPhone6_6s){\
temp = iPhone6;\
}\
else if (is_iPhone6Plus_6sP){\
temp = iPhone6Plus;\
}\
temp;\
})

#define AdaptIPad_IPhone4And5_6_6Plus(iPad,iPhone4and5,iPhone6,iPhone6Plus) AdaptIPad_IPhone4_5_6_6PLUS(iPad,iPhone4and5,iPhone4and5,iPhone6,iPhone6Plus)

// Color
#define UIColorFromHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGB(r, g, b, a) [UIColor colorWithRed:((float)(r))/255 green:((float)g)/255 blue:((float)b)/255 alpha:(a)]

#define ImageNamed(x) [UIImage imageNamed:(x)]

// Debug log
#ifdef DEBUG
#define DebugLog(...) NSLog(__VA_ARGS__)
#else
#define DebugLog(...)
#endif


extern NSString * const aConstant;
