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
    if (!deviceModel) {
        return nil;
    }
        
    // Apple设备型号总览: https://www.theiphonewiki.com/wiki/Models
    NSDictionary *dic = @{
        // 1. iPhone 系列
        @"iPhone1,1" : @"iPhone 1G",
        @"iPhone1,2" : @"iPhone 3G",
        @"iPhone2,1" : @"iPhone 3GS",
        @"iPhone3,1" : @"iPhone 4 (GSM)",
        @"iPhone3,2" : @"iPhone 4",
        @"iPhone3,3" : @"iPhone 4 (CDMA)",
        @"iPhone4,1" : @"iPhone 4S",
        @"iPhone5,1" : @"iPhone 5",
        @"iPhone5,2" : @"iPhone 5",
        @"iPhone5,3" : @"iPhone 5c",
        @"iPhone5,4" : @"iPhone 5c",
        @"iPhone6,1" : @"iPhone 5s",
        @"iPhone6,2" : @"iPhone 5s",
        @"iPhone7,1" : @"iPhone 6 Plus",
        @"iPhone7,2" : @"iPhone 6",
        @"iPhone8,1" : @"iPhone 6s",
        @"iPhone8,2" : @"iPhone 6s Plus",
        @"iPhone8,4" : @"iPhone SE",
        @"iPhone9,1" : @"iPhone 7",
        @"iPhone9,2" : @"iPhone 7 Plus",
        @"iPhone9,3" : @"iPhone 7",
        @"iPhone9,4" : @"iPhone 7 Plus",
        @"iPhone10,1" : @"iPhone 8",
        @"iPhone10,2" : @"iPhone 8 Plus",
        @"iPhone10,3" : @"iPhone X",
        @"iPhone10,4" : @"iPhone 8",
        @"iPhone10,5" : @"iPhone 8 Plus",
        @"iPhone10,6" : @"iPhone X",
        @"iPhone11,2" : @"iPhone Xs",
        @"iPhone11,4" : @"iPhone Xs Max",
        @"iPhone11,6" : @"iPhone Xs Max",
        @"iPhone11,8" : @"iPhone XR",
        @"iPhone12,1" : @"iPhone 11",
        @"iPhone12,3" : @"iPhone 11 Pro",
        @"iPhone12,5" : @"iPhone 11 Pro Max",
        @"iPhone12,8" : @"iPhone SE 2",
        @"iPhone13,1" : @"iPhone 12 mini",
        @"iPhone13,2" : @"iPhone 12",
        @"iPhone13,3" : @"iPhone 12 Pro",
        @"iPhone13,4" : @"iPhone 12 Pro Max",
        @"iPhone14,2" : @"iPhone 13 Pro",
        @"iPhone14,3" : @"iPhone 13 Pro Max",
        @"iPhone14,4" : @"iPhone 13 mini",
        @"iPhone14,5" : @"iPhone 13",
        @"iPhone14,6" : @"iPhone SE 3",
        
        // 2. iPod 系列
        @"iPod1,1" : @"iPod touch 1",
        @"iPod2,1" : @"iPod touch 2",
        @"iPod3,1" : @"iPod touch 3",
        @"iPod4,1" : @"iPod touch 4",
        @"iPod5,1" : @"iPod touch 5",
        @"iPod7,1" : @"iPod touch 6",
        @"iPod9,1" : @"iPod touch 7",

        // 3. iPad 系列
        // iPad
        @"iPad1,1" : @"iPad 1",
        @"iPad2,1" : @"iPad 2 (WiFi)",
        @"iPad2,2" : @"iPad 2 (GSM)",
        @"iPad2,3" : @"iPad 2 (CDMA)",
        @"iPad2,4" : @"iPad 2",
        @"iPad3,1" : @"iPad 3 (WiFi)",
        @"iPad3,2" : @"iPad 3 (CDMA)",
        @"iPad3,3" : @"iPad 3 (4G)",
        @"iPad3,4" : @"iPad 4 (WiFi)",
        @"iPad3,5" : @"iPad 4 (4G)",
        @"iPad3,6" : @"iPad 4 (CDMA)",
        @"iPad6,11" : @"iPad 5",
        @"iPad6,12" : @"iPad 5",
        @"iPad7,5" : @"iPad 6",
        @"iPad7,6" : @"iPad 6",
        @"iPad7,11" : @"iPad 7",
        @"iPad7,12" : @"iPad 7",
        @"iPad11,6" : @"iPad 8",
        @"iPad11,7" : @"iPad 8",
        @"iPad12,1" : @"iPad 9",
        @"iPad12,2" : @"iPad 9",
        // iPad Air
        @"iPad4,1" : @"iPad Air",
        @"iPad4,2" : @"iPad Air",
        @"iPad4,3" : @"iPad Air",
        @"iPad5,3" : @"iPad Air 2",
        @"iPad5,4" : @"iPad Air 2",
        @"iPad11,3" : @"iPad Air 3",
        @"iPad11,4" : @"iPad Air 3",
        @"iPad13,1" : @"iPad Air 4",
        @"iPad13,2" : @"iPad Air 4",
        @"iPad13,16" : @"iPad Air 5",
        @"iPad13,17" : @"iPad Air 5",
        // iPad Pro
        @"iPad6,3" : @"iPad Pro (9.7-inch)",
        @"iPad6,4" : @"iPad Pro (9.7-inch)",
        @"iPad6,7" : @"iPad Pro (12.9-inch)",
        @"iPad6,8" : @"iPad Pro (12.9-inch)",
        @"iPad7,1" : @"iPad Pro 2 (12.9-inch)",
        @"iPad7,2" : @"iPad Pro 2 (12.9-inch)",
        @"iPad7,3" : @"iPad Pro (10.5-inch)",
        @"iPad7,4" : @"iPad Pro (10.5-inch)",
        @"iPad8,1" : @"iPad Pro (11-inch)",
        @"iPad8,2" : @"iPad Pro (11-inch)",
        @"iPad8,3" : @"iPad Pro (11-inch)",
        @"iPad8,4" : @"iPad Pro (11-inch)",
        @"iPad8,5" : @"iPad Pro 3 (12.9-inch)",
        @"iPad8,6" : @"iPad Pro 3 (12.9-inch)",
        @"iPad8,7" : @"iPad Pro 3 (12.9-inch)",
        @"iPad8,8" : @"iPad Pro 3 (12.9-inch)",
        @"iPad8,9"  : @"iPad Pro 2 (11-inch)",
        @"iPad8,10" : @"iPad Pro 2 (11-inch)",
        @"iPad8,11" : @"iPad Pro 4 (12.9-inch)",
        @"iPad8,12" : @"iPad Pro 4 (12.9-inch)",
        @"iPad13,4" : @"iPad Pro 3 (11-inch)",
        @"iPad13,5" : @"iPad Pro 3 (11-inch)",
        @"iPad13,6" : @"iPad Pro 3 (11-inch)",
        @"iPad13,7" : @"iPad Pro 3 (11-inch)",
        @"iPad13,8"  : @"iPad Pro 5 (12.9-inch)",
        @"iPad13,9"  : @"iPad Pro 5 (12.9-inch)",
        @"iPad13,10" : @"iPad Pro 5 (12.9-inch)",
        @"iPad13,11" : @"iPad Pro 5 (12.9-inch)",
        // iPad mini
        @"iPad2,5" : @"iPad mini 1 (WiFi)",
        @"iPad2,6" : @"iPad mini 1 (GSM)",
        @"iPad2,7" : @"iPad mini 1 (CDMA)",
        @"iPad4,4" : @"iPad mini 2",
        @"iPad4,5" : @"iPad mini 2",
        @"iPad4,6" : @"iPad mini 2",
        @"iPad4,7" : @"iPad mini 3",
        @"iPad4,8" : @"iPad mini 3",
        @"iPad4,9" : @"iPad mini 3",
        @"iPad5,1" : @"iPad mini 4",
        @"iPad5,2" : @"iPad mini 4",
        @"iPad11,1" : @"iPad mini 5",
        @"iPad11,2" : @"iPad mini 5",
        @"iPad14,1" : @"iPad mini 6",
        @"iPad14,2" : @"iPad mini 6",
        
        // 4. Apple Watch 系列
        @"Watch1,1" : @"Apple Watch 38mm",
        @"Watch1,2" : @"Apple Watch 42mm",
        @"Watch2,3" : @"Apple Watch Series 2 38mm",
        @"Watch2,4" : @"Apple Watch Series 2 42mm",
        @"Watch2,6" : @"Apple Watch Series 1 38mm",
        @"Watch2,7" : @"Apple Watch Series 1 42mm",
        @"Watch3,1" : @"Apple Watch Series 3 38mm",
        @"Watch3,2" : @"Apple Watch Series 3 42mm",
        @"Watch3,3" : @"Apple Watch Series 3 38mm",
        @"Watch3,4" : @"Apple Watch Series 3 42mm",
        @"Watch4,1" : @"Apple Watch Series 4 40mm",
        @"Watch4,2" : @"Apple Watch Series 4 44mm",
        @"Watch4,3" : @"Apple Watch Series 4 40mm",
        @"Watch4,4" : @"Apple Watch Series 4 44mm",
        @"Watch5,1" : @"Apple Watch Series 5 40mm",
        @"Watch5,2" : @"Apple Watch Series 5 44mm",
        @"Watch5,3" : @"Apple Watch Series 5 40mm",
        @"Watch5,4" : @"Apple Watch Series 5 44mm",
        @"Watch5,9"  : @"Apple Watch SE 40mm",
        @"Watch5,10" : @"Apple Watch SE 44mm",
        @"Watch5,11" : @"Apple Watch SE 40mm",
        @"Watch5,12" : @"Apple Watch SE 44mm",
        @"Watch6,1" : @"Apple Watch Series 6 40mm",
        @"Watch6,2" : @"Apple Watch Series 6 44mm",
        @"Watch6,3" : @"Apple Watch Series 6 40mm",
        @"Watch6,4" : @"Apple Watch Series 6 44mm",
        @"Watch6,6" : @"Apple Watch Series 7 41mm",
        @"Watch6,7" : @"Apple Watch Series 7 45mm",
        @"Watch6,8" : @"Apple Watch Series 7 41mm",
        @"Watch6,9" : @"Apple Watch Series 7 45mm",
        
        // 5. Apple TV 系列
        @"AppleTV1,1" : @"Apple TV 1",
        @"AppleTV2,1" : @"Apple TV 2",
        @"AppleTV3,1" : @"Apple TV 3",
        @"AppleTV3,2" : @"Apple TV 3",
        @"AppleTV5,3" : @"Apple TV 4",
        @"AppleTV6,2"  : @"Apple TV 4K",
        @"AppleTV11,1" : @"Apple TV 4K 2",
        
        // 6. AirPods 系列
        @"AirPods1,1" : @"AirPods 1",
        @"AirPods1,2" : @"AirPods 2",
        @"AirPods2,1" : @"AirPods 2",
        @"AirPods1,3" : @"AirPods 3",
        @"Audio2,1"   : @"AirPods 3",
        @"AirPods2,2"    : @"AirPods Pro",
        @"AirPodsPro1,1" : @"AirPods Pro",
        @"iProd8,1"      : @"AirPods Pro",
        @"iProd8,6"      : @"AirPods Max",
        @"AirPodsMax1,1" : @"AirPods Max",
        
        // 7. HomePod 系列
        @"AudioAccessory1,1" : @"HomePod",
        @"AudioAccessory1,2" : @"HomePod",
        
        // 8. Apple Pencil 系列 (暂时未知)
//        @"Unknown" : @"Apple Pencil",
//        @"Unknown" : @"Apple Pencil 2",
        
        // 9. Smart Keyboard 系列 (暂时未知)
//        @"Unknown" : @"Smart Keyboard",
//        @"Unknown" : @"Smart Keyboard Folio",
        
        // 10. Siri Remote 系列 (暂时未知)
//        @"Unknown" : @"Siri Remote",
//        @"Unknown" : @"Siri Remote 2",
//        @"Unknown" : @"Siri Remote 3",
        
        // 11. AirTag
        @"AirTag1,1" : @"AirTag",

        // 模拟器
        @"i386"   : @"Simulator x86",
        @"x86_64" : @"Simulator x64",
    };
    NSString *name = dic[deviceModel];
    if (!name) {
        name = deviceModel;
    }
    return name;
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
