//
//  NSDeviceHelper.m
//
//
//  Created on 6/25/11.
//  Copyright 2011 Inc. All rights reserved.
//

#import "NSDeviceHelper.h"
#import "NSOpenUDID.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <netdb.h>
#include <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import <AdSupport/AdSupport.h>

static SCNetworkReachabilityRef defaultRouteReachability;

@implementation NSDeviceHelper

+ (BOOL)isDeviceIPad {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

+ (BOOL)isDeviceIPhone {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

+ (BOOL)deviceHasRetinaScreen {
    return ([UIScreen mainScreen].scale >= 2.0f);
}

+ (CGFloat)iosVersion {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

/*
 Platforms
 
 iFPGA ->        ??
 
 iPhone1,1 ->    iPhone 1G, M68
 iPhone1,2 ->    iPhone 3G, N82
 iPhone2,1 ->    iPhone 3GS, N88
 iPhone3,1 ->    iPhone 4/AT&T, N89
 iPhone3,2 ->    iPhone 4/Other Carrier?, ??
 iPhone3,3 ->    iPhone 4/Verizon, TBD
 iPhone4,1 ->    (iPhone 4S/GSM), TBD
 iPhone4,2 ->    (iPhone 4S/CDMA), TBD
 iPhone4,3 ->    (iPhone 4S/???)
 iPhone5,1 ->    iPhone Next Gen, TBD
 iPhone5,1 ->    iPhone Next Gen, TBD
 iPhone5,1 ->    iPhone Next Gen, TBD
 
 iPod1,1   ->    iPod touch 1G, N45
 iPod2,1   ->    iPod touch 2G, N72
 iPod2,2   ->    Unknown, ??
 iPod3,1   ->    iPod touch 3G, N18
 iPod4,1   ->    iPod touch 4G, N80
 
 // Thanks NSForge
 iPad1,1   ->    iPad 1G, WiFi and 3G, K48
 iPad2,1   ->    iPad 2G, WiFi, K93
 iPad2,2   ->    iPad 2G, GSM 3G, K94
 iPad2,3   ->    iPad 2G, CDMA 3G, K95
 iPad3,1   ->    (iPad 3G, WiFi)
 iPad3,2   ->    (iPad 3G, GSM)
 iPad3,3   ->    (iPad 3G, CDMA)
 iPad4,1   ->    (iPad 4G, WiFi)
 iPad4,2   ->    (iPad 4G, GSM)
 iPad4,3   ->    (iPad 4G, CDMA)
 
 AppleTV2,1 ->   AppleTV 2, K66
 AppleTV3,1 ->   AppleTV 3, ??
 
 i386, x86_64 -> iPhone Simulator
 */


#pragma mark sysctlbyname utils
+ (NSString *) getSysInfoByName:(char *)typeSpecifier
{
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    return results;
}

+ (NSString *) platform
{
    return [self getSysInfoByName:"hw.machine"];
}


// Thanks, Tom Harrington (Atomicbird)
+ (NSString *) hwmodel
{
    return [self getSysInfoByName:"hw.model"];
}

#pragma mark sysctl utils
+ (NSUInteger) getSysInfo: (uint) typeSpecifier
{
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}

+ (NSUInteger) cpuFrequency
{
    return [self getSysInfo:HW_CPU_FREQ];
}

+ (NSUInteger) busFrequency
{
    return [self getSysInfo:HW_BUS_FREQ];
}

+ (NSUInteger) cpuCount
{
    return [self getSysInfo:HW_NCPU];
}

+ (NSUInteger) totalMemory
{
    return [self getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger) userMemory
{
    return [self getSysInfo:HW_USERMEM];
}

+ (NSUInteger) maxSocketBufferSize
{
    return [self getSysInfo:KIPC_MAXSOCKBUF];
}

#pragma mark file system -- Thanks Joachim Bean!

/*
 extern NSString *NSFileSystemSize;
 extern NSString *NSFileSystemFreeSize;
 extern NSString *NSFileSystemNodes;
 extern NSString *NSFileSystemFreeNodes;
 extern NSString *NSFileSystemNumber;
 */

+ (NSNumber *) totalDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

+ (NSNumber *) freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

#pragma mark platform type and name utils
+ (ILSDeviceModel) modelType
{
    NSString *platform = [self platform];
    
    // The ever mysterious iFPGA
    if ([platform isEqualToString:@"iFPGA"])        return ILSDeviceIFPGA;
    
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"])    return ILSDevice1GiPhone;
    if ([platform isEqualToString:@"iPhone1,2"])    return ILSDevice3GiPhone;
    if ([platform hasPrefix:@"iPhone2"])            return ILSDevice3GSiPhone;
    if ([platform hasPrefix:@"iPhone3"])            return ILSDevice4iPhone;
    if ([platform hasPrefix:@"iPhone4"])            return ILSDevice4SiPhone;
    if ([platform isEqualToString:@"iPhone5,1"])      return ILSDevice5iPhone;
    if ([platform isEqualToString:@"iPhone5,2"])      return ILSDevice5iPhone;
    if ([platform isEqualToString:@"iPhone5,3"])      return ILSDevice5CiPhone;
    if ([platform isEqualToString:@"iPhone5,4"])      return ILSDevice5CiPhone;
    if ([platform hasPrefix:@"iPhone6"])            return ILSDevice5SiPhone;
    if ([platform isEqualToString:@"iPhone7,2"])      return ILSDevice6iPhone;
    if ([platform isEqualToString:@"iPhone7,1"])      return ILSDevice6PlusiPhone;

    // iPod
    if ([platform hasPrefix:@"iPod1"])              return ILSDevice1GiPod;
    if ([platform hasPrefix:@"iPod2"])              return ILSDevice2GiPod;
    if ([platform hasPrefix:@"iPod3"])              return ILSDevice3GiPod;
    if ([platform hasPrefix:@"iPod4"])              return ILSDevice4GiPod;
    if ([platform hasPrefix:@"iPod5"])              return ILSDevice5GiPod;
    // iPad
    if ([platform hasPrefix:@"iPad1"])              return ILSDevice1GiPad;
    if ([platform isEqualToString:@"iPad2,1"])      return ILSDevice2GiPad;
    if ([platform isEqualToString:@"iPad2,2"])      return ILSDevice2GiPad;
    if ([platform isEqualToString:@"iPad2,3"])      return ILSDevice2GiPad;
    if ([platform isEqualToString:@"iPad2,4"])      return ILSDevice2GiPad;
    if ([platform isEqualToString:@"iPad3,1"])      return ILSDevice3GiPad;
    if ([platform isEqualToString:@"iPad3,2"])      return ILSDevice3GiPad;
    if ([platform isEqualToString:@"iPad3,3"])      return ILSDevice3GiPad;
    if ([platform isEqualToString:@"iPad3,4"])      return ILSDevice4GiPad;
    if ([platform isEqualToString:@"iPad3,5"])      return ILSDevice4GiPad;
    if ([platform isEqualToString:@"iPad3,6"])      return ILSDevice4GiPad;
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])      return ILSDeviceiPadAir;
    if ([platform isEqualToString:@"iPad4,2"])      return ILSDeviceiPadAir;
    if ([platform isEqualToString:@"iPad4,3"])      return ILSDeviceiPadAir;
    if ([platform isEqualToString:@"iPad5,3"])      return ILSDeviceiPadAir2G;
    if ([platform isEqualToString:@"iPad5,4"])      return ILSDeviceiPadAir2G;

    //iPad Mini
    if ([platform isEqualToString:@"iPad2,5"])      return ILSDeviceMiniPad;//Mini1
    if ([platform isEqualToString:@"iPad2,6"])      return ILSDeviceMiniPad;//Mini1
    if ([platform isEqualToString:@"iPad2,7"])      return ILSDeviceMiniPad;//Mini1
    if ([platform isEqualToString:@"iPad4,4"])      return ILSDeviceMiniPad2G;//Mini2
    if ([platform isEqualToString:@"iPad4,5"])      return ILSDeviceMiniPad2G;//Mini2
    if ([platform isEqualToString:@"iPad4,6"])      return ILSDeviceMiniPad2G;//Mini2
    if ([platform isEqualToString:@"iPad4,7"])      return ILSDeviceMiniPad3G;//Mini3
    if ([platform isEqualToString:@"iPad4,8"])      return ILSDeviceMiniPad3G;//Mini3
    if ([platform isEqualToString:@"iPad4,9"])      return ILSDeviceMiniPad3G;//Mini3

    // Apple TV
    if ([platform hasPrefix:@"AppleTV2"])           return ILSDeviceAppleTV2;
    if ([platform hasPrefix:@"AppleTV3"])           return ILSDeviceAppleTV3;
    
    if ([platform hasPrefix:@"iPhone"])             return ILSDeviceUnknowniPhone;
    if ([platform hasPrefix:@"iPod"])               return ILSDeviceUnknowniPod;
    if ([platform hasPrefix:@"iPad"])               return ILSDeviceUnknowniPad;
    if ([platform hasPrefix:@"AppleTV"])            return ILSDeviceUnknownAppleTV;
    
    // Simulator thanks Jordan Breeding
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
    {
        BOOL smallerScreen = MIN([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) < 768;
        return smallerScreen ? ILSDeviceSimulatoriPhone : ILSDeviceSimulatoriPad;
    }
    
    return ILSDeviceUnknown;
}
+ (NSString *)modelTypeString {
    ILSDeviceModel deviceModel = [NSDeviceHelper modelType];
    NSString *deviceModelString = @"Unknown";
    switch (deviceModel) {
        case ILSDeviceSimulator:
            deviceModelString = @"iOS Simulator";
            break;
        case ILSDeviceSimulatoriPhone:
            deviceModelString = @"iPhone Simulator";
            break;
        case ILSDeviceSimulatoriPad:
            deviceModelString = @"iPad Simulator";
            break;
        case ILSDeviceSimulatorAppleTV:
            deviceModelString = @"AppleTV Simulator";
            break;
        case ILSDevice1GiPhone:
            deviceModelString = @"iPhone 1G";
            break;
        case ILSDevice3GiPhone:
            deviceModelString = @"iPhone 3G";
            break;
        case ILSDevice3GSiPhone:
            deviceModelString = @"iPhone 3GS";
            break;
        case ILSDevice4iPhone:
            deviceModelString = @"iPhone 4";
            break;
        case ILSDevice4SiPhone:
            deviceModelString = @"iPhone 4S";
            break;
        case ILSDevice5iPhone:
            deviceModelString = @"iPhone 5";
            break;
        case ILSDevice5CiPhone:
            deviceModelString = @"iPhone 5C";
            break;
        case ILSDevice5SiPhone:
            deviceModelString = @"iPhone 5S";
            break;
        case ILSDevice1GiPod:
            deviceModelString = @"iPod 1G";
            break;
        case ILSDevice2GiPod:
            deviceModelString = @"iPod 2G";
            break;
        case ILSDevice3GiPod:
            deviceModelString = @"iPod 3G";
            break;
        case ILSDevice4GiPod:
            deviceModelString = @"iPod 4G";
            break;
        case ILSDevice5GiPod:
            deviceModelString = @"iPod 5G";
            break;
        case ILSDevice1GiPad:
            deviceModelString = @"iPad 1G";
            break;
        case ILSDevice2GiPad:
            deviceModelString = @"iPad 2G";
            break;
        case ILSDevice3GiPad:
            deviceModelString = @"iPad 3G";
            break;
        case ILSDevice4GiPad:
            deviceModelString = @"iPad 4G";
            break;
        case ILSDeviceMiniPad:
            deviceModelString = @"iPad Mini";
            break;
        case ILSDeviceiPadAir:
            deviceModelString = @"iPad Air";
            break;
        case ILSDeviceMiniPad2G:
            deviceModelString = @"iPad Mini 2G";
            break;
        case ILSDevice6iPhone:
            deviceModelString = @"iPhone 6";
            break;
        case ILSDevice6PlusiPhone:
            deviceModelString = @"iPhone 6 Plus";
            break;
        case ILSDeviceiPadAir2G:
            deviceModelString = @"iPad Air 2G";
            break;
        case ILSDeviceMiniPad3G:
            deviceModelString = @"iPad Mini 3G";
            break;
        default:
            deviceModelString = [self platform];
            break;
    }
    
    return deviceModelString;
}
+ (NSString *)modelString {
    return [self platform];
}

+ (ILSDeviceFamily) deviceFamily
{
    NSString *platform = [self platform];
    if ([platform hasPrefix:@"iPhone"]) return ILSDeviceFamilyiPhone;
    if ([platform hasPrefix:@"iPod"]) return ILSDeviceFamilyiPod;
    if ([platform hasPrefix:@"iPad"]) return ILSDeviceFamilyiPad;
    if ([platform hasPrefix:@"AppleTV"]) return ILSDeviceFamilyAppleTV;
    
    return ILSDeviceFamilyUnknown;
}

+ (BOOL)isInternetConnectionAvailable {
	if (!defaultRouteReachability) {
		struct sockaddr_in zeroAddress;
		bzero(&zeroAddress, sizeof(zeroAddress));
		zeroAddress.sin_len = sizeof(zeroAddress);
		zeroAddress.sin_family = AF_INET;
		defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	}
	SCNetworkReachabilityFlags flags;
	BOOL gotFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	if (!gotFlags) {
        return NO;
    }
    
	BOOL isReachable = flags & kSCNetworkReachabilityFlagsReachable;
	if (!isReachable)
		return NO;
	BOOL noConnectionRequired = !(flags & kSCNetworkReachabilityFlagsConnectionRequired);
	if ((flags & kSCNetworkReachabilityFlagsIsWWAN)) {
		noConnectionRequired = YES;
	}
	if (!noConnectionRequired)
		return NO;
	
	if (flags & kSCNetworkReachabilityFlagsIsDirect) {
		// The connection is to an ad-hoc WiFi network, so Internet access is not available.
		return NO;
	} else {
		return YES;
	}
}


+ (NSString *)uniqueDeviceIdentifier{
//    if ([self iosVersion] > 5.999) {
//        NSString *adId = [[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] lowercaseString];
//        if (adId != nil && [adId length]>2)
//            return [NSString stringWithFormat:@"a%@", [adId stringByReplacingOccurrencesOfString:@"-" withString:@""]];
//        else {
//            adId = [[[UIDevice currentDevice].identifierForVendor UUIDString] lowercaseString];
//            return [NSString stringWithFormat:@"v%@", [adId stringByReplacingOccurrencesOfString:@"-" withString:@""]];
//        }
//    } else {
//        return [NSString stringWithFormat:@"c%@", [self customDeviceUUID]];
//    }
    
    return [NSString stringWithFormat:@"o%@", [NSOpenUDID value]];
}

+ (NSString *)currentLocaleId {
    NSString *str = [[NSLocale currentLocale] localeIdentifier];
    if ([str rangeOfString:@"@"].location != NSNotFound) {
        return [str substringToIndex:[str rangeOfString:@"@"].location];
    } else {
        return str;
    }
}

+ (CGSize)currentScreenSize {
    return [UIScreen mainScreen].bounds.size;
}

+ (BOOL)isScreen480Height
{
    return (fabs(MAX([NSDeviceHelper currentScreenSize].width, [NSDeviceHelper currentScreenSize].height) - 480) < 0.001);
}

+ (BOOL)isScreen568Height {
    return (fabs(MAX([NSDeviceHelper currentScreenSize].width, [NSDeviceHelper currentScreenSize].height) - 568) < 0.001);
}
+ (BOOL)isScreenMoreThanOrEqualTo568Height {
    return (MAX([NSDeviceHelper currentScreenSize].width, [NSDeviceHelper currentScreenSize].height) - 568 >= 0);
}

+ (BOOL)isScreen667Height {
    return (fabs(MAX([NSDeviceHelper currentScreenSize].width, [NSDeviceHelper currentScreenSize].height) - 667) < 0.001);
}

+ (BOOL)isScreen736Height {
    return (fabs(MAX([NSDeviceHelper currentScreenSize].width, [NSDeviceHelper currentScreenSize].height) - 736) < 0.001);
}

+ (BOOL)isIPhone5 {
    ILSDeviceModel model = [self modelType];
    return (model == ILSDevice5iPhone) || (model == ILSDevice5CiPhone) || (model == ILSDevice5SiPhone);
}

+ (BOOL)isIPhone6 {
    return [self modelType] == ILSDevice6iPhone;
}

+ (BOOL)isIPhone6Plus {
    return [self modelType] == ILSDevice6PlusiPhone;
}
@end
