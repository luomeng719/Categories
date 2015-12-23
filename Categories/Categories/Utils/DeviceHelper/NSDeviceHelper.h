//
//  NSDeviceHelper.h
//
//
//  Created on 6/25/11.
//  Copyright 2011 Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//SAMPLE:SYSTEM_VERSION_EQUAL_TO(@"5.0.1")
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


typedef enum {
    ILSDeviceUnknown,
    
    ILSDeviceSimulator,
    ILSDeviceSimulatoriPhone,
    ILSDeviceSimulatoriPad,
    ILSDeviceSimulatorAppleTV,
    
    ILSDevice1GiPhone,
    ILSDevice3GiPhone,
    ILSDevice3GSiPhone,
    ILSDevice4iPhone,
    ILSDevice4SiPhone,
    ILSDevice5iPhone,
    ILSDevice5CiPhone,
    ILSDevice5SiPhone,
    
    ILSDevice1GiPod,
    ILSDevice2GiPod,
    ILSDevice3GiPod,
    ILSDevice4GiPod,
    ILSDevice5GiPod,//15
    
    ILSDevice1GiPad,
    ILSDevice2GiPad,
    ILSDevice3GiPad,
    ILSDevice4GiPad,
    ILSDeviceMiniPad,
    ILSDeviceiPadAir,
    ILSDeviceMiniPad2G,
    
    ILSDeviceAppleTV2,
    ILSDeviceAppleTV3,
    ILSDeviceAppleTV4,
    
    ILSDeviceUnknowniPhone,
    ILSDeviceUnknowniPod,
    ILSDeviceUnknowniPad,
    ILSDeviceUnknownAppleTV,
    ILSDeviceIFPGA,

    ILSDevice6iPhone,
    ILSDevice6PlusiPhone,
    ILSDeviceiPadAir2G,
    ILSDeviceMiniPad3G,

} ILSDeviceModel;

typedef enum {
    ILSDeviceFamilyiPhone,
    ILSDeviceFamilyiPod,
    ILSDeviceFamilyiPad,
    ILSDeviceFamilyAppleTV,
    ILSDeviceFamilyUnknown,
    
} ILSDeviceFamily;

@interface NSDeviceHelper : NSObject {
    
}

+ (BOOL)isDeviceIPad;
+ (BOOL)isDeviceIPhone;
+ (BOOL)deviceHasRetinaScreen;
+ (CGFloat)iosVersion;

+ (NSNumber *)totalDiskSpace;
+ (NSNumber *)freeDiskSpace;
+ (ILSDeviceModel)modelType;
+ (NSString*)modelTypeString;

+ (NSString *)modelString;
+ (ILSDeviceFamily)deviceFamily;

+ (NSUInteger)userMemory;
+ (NSUInteger)totalMemory;
+ (NSUInteger)cpuCount;
+ (NSUInteger)busFrequency;
+ (NSUInteger)cpuFrequency;

+ (BOOL)isInternetConnectionAvailable;

+ (NSString *)uniqueDeviceIdentifier;
+ (NSString *)currentLocaleId;
+ (CGSize)currentScreenSize;
+ (BOOL)isScreen480Height;
+ (BOOL)isScreen568Height;
+ (BOOL)isScreen667Height;
+ (BOOL)isScreen736Height;
+ (BOOL)isScreenMoreThanOrEqualTo568Height;

+ (BOOL)isIPhone5;
+ (BOOL)isIPhone6;
+ (BOOL)isIPhone6Plus;

@end
