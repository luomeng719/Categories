//
//  MPNVoiceManager.m
//  MaskPhoneNumber
//
//  Created by luomeng on 15/10/28.
//  Copyright © 2015年 ILegendsoft. All rights reserved.
//

#import "MPNVoiceManager.h"
#import <AudioToolbox/AudioToolbox.h>

static NSString * const kInCommingCallVoiceName = @"2620.wav";
static NSString * const kRecevingMessageName = @"sendVoice.mp3";

@implementation MPNVoiceManager {
    SystemSoundID soundId;
}

+ (id)sharedManager {
    static MPNVoiceManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MPNVoiceManager alloc] init];
    });
    return manager;
}

#pragma mark - 持续震动/响铃
void soundCompleteCallback(SystemSoundID sound,void * clientData) {
    [NSThread sleepForTimeInterval:0.6];
    AudioServicesPlaySystemSound(sound);
}

void vibrateCompleteCallback(SystemSoundID soundID, void * clientData) {
    [NSThread sleepForTimeInterval:0.6];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

/**
 *  持续震动
 */

- (void)playVibrateAroundForIncommingCall {
    // block crash on ios8.4
//    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL, soundCompleteCallback, NULL);
//    AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, ^{
//        [NSThread sleepForTimeInterval:0.4];
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//    });
    if (!self.isVibrating) {
        _isVibrating = YES;
        AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL, vibrateCompleteCallback, NULL);
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

/**
 * 连续响铃
 */
- (void)playSoundAroundForIncommingCall {
    if (!self.isPlayingSound) {
        _isPlayingSound = YES;
        NSURL *url = [[NSBundle mainBundle] URLForResource:kInCommingCallVoiceName withExtension:nil];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundId);
        AudioServicesAddSystemSoundCompletion(soundId, NULL, NULL, soundCompleteCallback, NULL);
        AudioServicesPlaySystemSound(soundId);
    }
}

/**
 * 停止震动和响铃
 */
- (void)stopVibrateAndSound {
    _isVibrating = NO;
    _isPlayingSound = NO;
    
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
    
    AudioServicesDisposeSystemSoundID(soundId);
    AudioServicesRemoveSystemSoundCompletion(soundId);
}

@end
