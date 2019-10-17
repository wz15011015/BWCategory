//
//  UIDevice+HDLHelper.h
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/8.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (HDLHelper)

/**
 设备名称
 
 @return 设备名称,如: "My iPhone"
 */
+ (NSString *)deviceName;

/**
 设备类型
 
 @return 设备类型,如: "iPhone", "iPod touch"
 */
+ (NSString *)deviceModel;

/**
 设备系统名称
 
 @return 系统名称,如: "iOS"
 */
+ (NSString *)deviceSysName;

/**
 设备系统版本
 
 @return 系统版本号,如: "12.0"
 */
+ (NSString *)deviceSysVersion;

/**
 设备机型
 
 @return 设备机型,如: "iPhone X"
 */
+ (NSString *)deviceModelName;

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
+ (NSString *)IDFVString;

NS_ASSUME_NONNULL_END

@end
