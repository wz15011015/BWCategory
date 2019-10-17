//
//  NSBundle+HDLHelper.h
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/8.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (HDLHelper)

/**
 App名称
 
 @return 名称
 */
+ (NSString *)appName;

/**
 App版本号
 
 @return 版本号
 */
+ (NSString *)appVersion;

/**
 App Build版本号
 
 @return 版本号
 */
+ (NSString *)appBuildVersion;

@end

NS_ASSUME_NONNULL_END
