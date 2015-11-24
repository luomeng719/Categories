//
//  MPNEmailManager.h
//  MaskPhoneNumber
//
//  Created by luomeng on 15/10/16.
//  Copyright (c) 2015年 ILegendsoft. All rights reserved.
//
//  发送Email  supportEmail

#import <Foundation/Foundation.h>

@interface MPNEmailManager : NSObject

+ (instancetype)defaultManager;

- (void)openEmailInViewController:(UIViewController *)vc
                      withSubject:(NSString *)subject
                        EmailBody:(NSString *)emailBody
                        fromEmail:(NSString *)yourSupportEmail;

@end
