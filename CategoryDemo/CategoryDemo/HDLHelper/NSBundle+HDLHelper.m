//
//  NSBundle+HDLHelper.m
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/8.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import "NSBundle+HDLHelper.h"

@implementation NSBundle (HDLHelper)

@end


// MARK: - App信息

@implementation NSBundle (AppInfo)

/**
 App Bundle Identifier

 @return Bundle Identifier
 */
+ (NSString *)appBundleIdentifier {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

/**
 App名称

 @return 名称
 */
+ (NSString *)appName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

/**
 App版本号

 @return 版本号
 */
+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

/**
 App Build版本号 / 构建版本号

 @return 版本号
 */
+ (NSString *)appBuildVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

@end
