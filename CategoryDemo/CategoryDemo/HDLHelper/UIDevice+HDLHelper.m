//
//  UIDevice+HDLHelper.m
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/8.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import "UIDevice+HDLHelper.h"
#import <sys/utsname.h>

@implementation UIDevice (HDLHelper)

/**
 设备名称,如: "My iPhone"
 
 在 "设置" --> "通用" --> "关于本机" --> "名称" 中设置的名称
 
 @return 设备名称
 */
+ (NSString *)deviceName {
    return [[UIDevice currentDevice] name];
}

/**
 设备类型,如: "iPhone", "iPod touch"
 
 @return 设备类型
 */
+ (NSString *)deviceModel {
    return [[UIDevice currentDevice] model];
}

/**
 设备系统名称,如: "iOS"
 
 @return 系统名称
 */
+ (NSString *)deviceSysName {
    return [[UIDevice currentDevice] systemName];
}

/**
 设备系统版本,如: "13.3"

 @return 系统版本号
 */
+ (NSString *)deviceSysVersion {
    return [[UIDevice currentDevice] systemVersion];
}

/**
 设备机型,如: "iPhone X"
 
 @return 设备机型
 */
+ (NSString *)deviceModelName {
    // 需要导入: #import <sys/utsname.h>
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
//    // Name of OS
//    NSString *sysname = [NSString stringWithCString:systemInfo.sysname encoding:NSASCIIStringEncoding];
//    // Name of this network node
//    NSString *nodename = [NSString stringWithCString:systemInfo.nodename encoding:NSASCIIStringEncoding];
//    // Release level
//    NSString *release = [NSString stringWithCString:systemInfo.release encoding:NSASCIIStringEncoding];
//    // Version level
//    NSString *version = [NSString stringWithCString:systemInfo.version encoding:NSASCIIStringEncoding];
   
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    // iOS设备型号总览: https://www.theiphonewiki.com/wiki/Models
    // 1. iPhone 系列
    if ([deviceModel isEqualToString:@"iPhone1,1"]) {
        return @"iPhone";
    }
    if ([deviceModel isEqualToString:@"iPhone1,2"]) {
        return @"iPhone 3G";
    }
    if ([deviceModel isEqualToString:@"iPhone2,1"]) {
        return @"iPhone 3GS";
    }
    if ([deviceModel isEqualToString:@"iPhone3,1"] ||
        [deviceModel isEqualToString:@"iPhone3,2"] ||
        [deviceModel isEqualToString:@"iPhone3,3"]) {
        return @"iPhone 4";
    }
    if ([deviceModel isEqualToString:@"iPhone4,1"]) {
        return @"iPhone 4S";
    }
    if ([deviceModel isEqualToString:@"iPhone5,1"] ||
        [deviceModel isEqualToString:@"iPhone5,2"]) {
        return @"iPhone 5";
    }
    if ([deviceModel isEqualToString:@"iPhone5,3"] ||
        [deviceModel isEqualToString:@"iPhone5,4"]) {
        return @"iPhone 5C";
    }
    if ([deviceModel isEqualToString:@"iPhone6,1"] ||
        [deviceModel isEqualToString:@"iPhone6,2"]) {
        return @"iPhone 5S";
    }
    if ([deviceModel isEqualToString:@"iPhone7,1"]) {
        return @"iPhone 6 Plus";
    }
    if ([deviceModel isEqualToString:@"iPhone7,2"]) {
        return @"iPhone 6";
    }
    if ([deviceModel isEqualToString:@"iPhone8,1"]) {
        return @"iPhone 6s";
    }
    if ([deviceModel isEqualToString:@"iPhone8,2"]) {
        return @"iPhone 6s Plus";
    }
    if ([deviceModel isEqualToString:@"iPhone8,4"]) {
        return @"iPhone SE";
    }
    if ([deviceModel isEqualToString:@"iPhone9,1"] ||
        [deviceModel isEqualToString:@"iPhone9,3"]) {
        return @"iPhone 7";
    }
    if ([deviceModel isEqualToString:@"iPhone9,2"] ||
        [deviceModel isEqualToString:@"iPhone9,4"]) {
        return @"iPhone 7 Plus";
    }
    if ([deviceModel isEqualToString:@"iPhone10,1"] ||
        [deviceModel isEqualToString:@"iPhone10,4"]) {
        return @"iPhone 8";
    }
    if ([deviceModel isEqualToString:@"iPhone10,2"] ||
        [deviceModel isEqualToString:@"iPhone10,5"]) {
        return @"iPhone 8 Plus";
    }
    if ([deviceModel isEqualToString:@"iPhone10,3"] ||
        [deviceModel isEqualToString:@"iPhone10,6"]) {
        return @"iPhone X";
    }
    if ([deviceModel isEqualToString:@"iPhone11,2"]) {
        return @"iPhone Xs";
    }
    if ([deviceModel isEqualToString:@"iPhone11,4"] ||
        [deviceModel isEqualToString:@"iPhone11,6"]) {
        return @"iPhone Xs Max";
    }
    if ([deviceModel isEqualToString:@"iPhone11,8"]) {
        return @"iPhone XR";
    }
    if ([deviceModel isEqualToString:@"iPhone12,1"]) {
        return @"iPhone 11";
    }
    if ([deviceModel isEqualToString:@"iPhone12,3"]) {
        return @"iPhone 11 Pro";
    }
    if ([deviceModel isEqualToString:@"iPhone12,5"]) {
        return @"iPhone 11 Pro Max";
    }
    
    // 2. iPod 系列
    if ([deviceModel isEqualToString:@"iPod1,1"]) {
        return @"iPod Touch";
    }
    if ([deviceModel isEqualToString:@"iPod2,1"]) {
        return @"iPod Touch 2";
    }
    if ([deviceModel isEqualToString:@"iPod3,1"]) {
        return @"iPod Touch 3";
    }
    if ([deviceModel isEqualToString:@"iPod4,1"]) {
        return @"iPod Touch 4";
    }
    if ([deviceModel isEqualToString:@"iPod5,1"]) {
        return @"iPod Touch 5";
    }
    if ([deviceModel isEqualToString:@"iPod7,1"]) {
        return @"iPod Touch 6";
    }
    if ([deviceModel isEqualToString:@"iPod9,1"]) {
        return @"iPod Touch 7";
    }
    
    // 3. iPad 系列
    if ([deviceModel isEqualToString:@"iPad1,1"]) {
        return @"iPad";
    }
    if ([deviceModel isEqualToString:@"iPad2,1"]) {
        return @"iPad 2 (WiFi)";
    }
    if ([deviceModel isEqualToString:@"iPad2,2"]) {
        return @"iPad 2 (GSM)";
    }
    if ([deviceModel isEqualToString:@"iPad2,3"]) {
        return @"iPad 2 (CDMA)";
    }
    if ([deviceModel isEqualToString:@"iPad2,4"]) {
        return @"iPad 2 (32nm)";
    }
    if ([deviceModel isEqualToString:@"iPad3,1"]) {
        return @"iPad 3(WiFi)";
    }
    if ([deviceModel isEqualToString:@"iPad3,2"]) {
        return @"iPad 3(CDMA)";
    }
    if ([deviceModel isEqualToString:@"iPad3,3"]) {
        return @"iPad 3(4G)";
    }
    if ([deviceModel isEqualToString:@"iPad3,4"]) {
        return @"iPad 4 (WiFi)";
    }
    if ([deviceModel isEqualToString:@"iPad3,5"]) {
        return @"iPad 4 (4G)";
    }
    if ([deviceModel isEqualToString:@"iPad3,6"]) {
        return @"iPad 4 (CDMA)";
    }
    
    if ([deviceModel isEqualToString:@"iPad4,1"] ||
        [deviceModel isEqualToString:@"iPad4,2"] ||
        [deviceModel isEqualToString:@"iPad4,3"]) {
        return @"iPad Air";
    }
    if ([deviceModel isEqualToString:@"iPad5,3"] ||
        [deviceModel isEqualToString:@"iPad5,4"]) {
        return @"iPad Air 2";
    }
    if ([deviceModel isEqualToString:@"iPad11,3"] ||
        [deviceModel isEqualToString:@"iPad11,4"]) {
        return @"iPad Air 3";
    }
    
    if ([deviceModel isEqualToString:@"iPad6,7"] ||
        [deviceModel isEqualToString:@"iPad6,8"]) {
        return @"iPad Pro (12.9-inch)";
    }
    if ([deviceModel isEqualToString:@"iPad6,3"] ||
        [deviceModel isEqualToString:@"iPad6,4"]) {
        return @"iPad Pro (9.7-inch)";
    }
    if ([deviceModel isEqualToString:@"iPad6,11"] ||
        [deviceModel isEqualToString:@"iPad6,12"]) {
        return @"iPad 5";
    }
    if ([deviceModel isEqualToString:@"iPad7,1"] ||
        [deviceModel isEqualToString:@"iPad7,2"]) {
        return @"iPad Pro 2 (12.9-inch)";
    }
    if ([deviceModel isEqualToString:@"iPad7,3"] ||
        [deviceModel isEqualToString:@"iPad7,4"]) {
        return @"iPad Pro (10.5-inch)";
    }
    if ([deviceModel isEqualToString:@"iPad7,5"] ||
        [deviceModel isEqualToString:@"iPad7,6"]) {
        return @"iPad 6";
    }
    if ([deviceModel isEqualToString:@"iPad8,1"] ||
        [deviceModel isEqualToString:@"iPad8,2"] ||
        [deviceModel isEqualToString:@"iPad8,3"] ||
        [deviceModel isEqualToString:@"iPad8,4"]) {
        return @"iPad Pro (11-inch)";
    }
    if ([deviceModel isEqualToString:@"iPad8,5"] ||
        [deviceModel isEqualToString:@"iPad8,6"] ||
        [deviceModel isEqualToString:@"iPad8,7"] ||
        [deviceModel isEqualToString:@"iPad8,8"]) {
        return @"iPad Pro 3 (12.9-inch)";
    }
    
    // 4. iPad mini 系列
    if ([deviceModel isEqualToString:@"iPad2,5"]) {
        return @"iPad mini (WiFi)";
    }
    if ([deviceModel isEqualToString:@"iPad2,6"]) {
        return @"iPad mini (GSM)";
    }
    if ([deviceModel isEqualToString:@"iPad2,7"]) {
        return @"iPad mini (CDMA)";
    }
    if ([deviceModel isEqualToString:@"iPad4,4"] ||
        [deviceModel isEqualToString:@"iPad4,5"] ||
        [deviceModel isEqualToString:@"iPad4,6"]) {
        return @"iPad mini 2";
    }
    if ([deviceModel isEqualToString:@"iPad4,7"] ||
        [deviceModel isEqualToString:@"iPad4,8"] ||
        [deviceModel isEqualToString:@"iPad4,9"]) {
        return @"iPad mini 3";
    }
    if ([deviceModel isEqualToString:@"iPad5,1"] ||
        [deviceModel isEqualToString:@"iPad5,2"]) {
        return @"iPad mini 4";
    }
    if ([deviceModel isEqualToString:@"iPad11,1"] ||
        [deviceModel isEqualToString:@"iPad11,2"]) {
        return @"iPad mini 5";
    }
    
    // 5. 模拟器
    if ([deviceModel isEqualToString:@"i386"] ||
        [deviceModel isEqualToString:@"x86_64"]) {
        return @"Simulator";
    }
    
    return deviceModel;
}

/**
 IDFV字符串 (identifierForVendor)
 
 1. 对于运行于同一个设备，并且来自同一个供应商的所有App，这个值都是相同的;
 
 2. 对于一个设备上来自不同供应商的app，这个值不同;
 
 3. 不同设备的app，无论供应商相同与否，这个值都不同;
 
 4. 如果此值为空，等一会再去获取。用户锁定设备后，再重启设备，此时获取为空，需要解锁;
 
 5. 当在设备上安装来自同一个供应商的不同App时，此值保持不变。
   如果你删除了来自某个供应商的所有app，再重新安装时，此值会改变。

 @return IDFV字符串
 */
+ (NSString *)IDFVString {
    NSUUID *identifier = [[UIDevice currentDevice] identifierForVendor];
    return identifier.UUIDString;
}

@end
