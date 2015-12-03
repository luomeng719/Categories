//
//  LMAudioManager.h
//  Test
//
//  Created by luomeng on 15/12/3.
//  Copyright © 2015年 luomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMAudioManager : NSObject

+ (instancetype)defaultManager;

/**
 * 启动Manager监听是否带耳机，并改变输出方式
 */
- (void)start;

+ (BOOL)hasHeadphones;

@end
