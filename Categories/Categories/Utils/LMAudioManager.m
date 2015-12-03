//
//  LMAudioManager.m
//  Test
//
//  Created by luomeng on 15/12/3.
//  Copyright © 2015年 luomeng. All rights reserved.
//

#import "LMAudioManager.h"
#import <AVFoundation/AVFoundation.h>

@implementation LMAudioManager

+ (instancetype)defaultManager {
    static LMAudioManager *manager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[LMAudioManager alloc] init];
    });
    
    return manager;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)start {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioOutputRouterChange:)
                                                 name:AVAudioSessionRouteChangeNotification
                                               object:[AVAudioSession sharedInstance]];
}


- (void)audioOutputRouterChange:(NSNotification *)notif {
    
    AVAudioSessionRouteDescription *route = [notif.userInfo objectForKey:@"AVAudioSessionRouteChangePreviousRouteKey"];
    
    if ([[notif.userInfo objectForKey:@"AVAudioSessionRouteChangeReasonKey"] integerValue] == AVAudioSessionRouteChangeReasonCategoryChange) {
        return;
    }
    
    for (AVAudioSessionPortDescription *outputRoute in route.outputs) {
        if (([outputRoute.portType rangeOfString:@"Headphones"].location != NSNotFound) ||
            ([outputRoute.portType rangeOfString:@"Headset"].location != NSNotFound)) {
            NSError *err = nil;
            [[AVAudioSession sharedInstance] overrideOutputAudioPort:kAudioSessionOverrideAudioRoute_Speaker error:&err];
            return;
        }
    }
}

/**
 * 检测是否有耳机
 */
+ (BOOL)hasHeadphones {
    AVAudioSessionRouteDescription *route = [AVAudioSession sharedInstance].currentRoute;
    
    for (AVAudioSessionPortDescription *outputRoute in route.outputs) {
        if (([outputRoute.portType rangeOfString:@"Headphones"].location != NSNotFound) ||
            ([outputRoute.portType rangeOfString:@"Headset"].location != NSNotFound)) {
            return YES;
        }
    }
    
    return NO;
}


@end
