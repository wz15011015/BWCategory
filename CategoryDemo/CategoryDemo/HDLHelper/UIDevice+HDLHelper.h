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
 设备名称,如: "My iPhone"
  
 在 "设置" --> "通用" --> "关于本机" --> "名称" 中设置的名称
  
 @return 设备名称
 */
+ (NSString *)deviceName;

/**
 设备类型,如: "iPhone", "iPod touch"
 
 @return 设备类型
 */
+ (NSString *)deviceModel;

/**
 设备系统名称,如: "iOS"
 
 @return 系统名称
 */
+ (NSString *)deviceSysName;

/**
 设备系统版本,如: "13.3"
 
 @return 系统版本号
 */
+ (NSString *)deviceSysVersion;

/**
 设备机型,如: "iPhone X"
 
 @return 设备机型
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
