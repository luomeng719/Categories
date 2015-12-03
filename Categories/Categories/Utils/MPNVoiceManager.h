//
//  MPNVoiceManager.h
//  MaskPhoneNumber
//
//  Created by luomeng on 15/10/28.
//  Copyright © 2015年 ILegendsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPNVoiceManager : NSObject

@property (nonatomic, assign, readonly) BOOL isVibrating;
@property (nonatomic, assign, readonly) BOOL isPlayingSound;

+ (id)sharedManager;

#pragma mark - 震动/播放系统声音
/**
 * 震动一次
 */
- (void)playVibrate;

/**
 * 播放一次自定义声音
 */
- (void)playSoundWithSoundName:(NSString *)soundName;


#pragma mark - 持续震动/响铃
/**
 *  持续震动
 */
- (void)playVibrateAroundForIncommingCall;

/**
 * 连续响铃
 */
- (void)playSoundAroundForIncommingCall;

/**
 * 停止震动和响铃
 */
- (void)stopVibrateAndSound;

@end
