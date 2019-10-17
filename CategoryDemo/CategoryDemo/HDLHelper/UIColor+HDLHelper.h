//
//  UIColor+HDLHelper.h
//  CategoryDemo
//
//  Created by Shaojun Han on 3/7/16.
//  Copyright © 2016 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 构造UIColor (HSB)
 
 @param hue 色度, 0 - 255
 @param saturation 饱和度, 0 - 255
 @param brightness 亮度, 0 - 255
 @param alpha 透明度, 0.0 - 1.0
 @return UIColor
 */
UIColor *HSBA(UInt8 hue, UInt8 saturation, UInt8 brightness, CGFloat alpha);

/**
 构造UIColor (HSB)
 
 @param hue 色度, 0 - 255
 @param saturation 饱和度, 0 - 255
 @param brightness 亮度, 0 - 255
 @return UIColor
 */
UIColor *HSB(UInt8 hue, UInt8 saturation, UInt8 brightness);

/**
 构造UIColor (RGB)
 
 @param red 红色, 0 - 255
 @param green 绿色, 0 - 255
 @param blue 蓝色, 0 - 255
 @param alpha 透明度, 0.0 - 1.0
 @return UIColor
 */
UIColor *RGBA(UInt8 red, UInt8 green, UInt8 blue, CGFloat alpha);

/**
 构造UIColor (RGB)
 
 @param red 红色, 0 - 255
 @param green 绿色, 0 - 255
 @param blue 蓝色, 0 - 255
 @return UIColor
 */
UIColor *RGB(UInt8 red, UInt8 green, UInt8 blue);

/**
 构造UIColor (RGB)
 
 @param rgba 长整型的rgb, 如红色: 0xFF0000FF (十六进制)
 @return UIColor
 */
UIColor *RGBAHex(unsigned long rgba);

/**
 构造UIColor (RGB)
 
 @param rgb 长整型的rgb, 如红色: 0xFF0000 (十六进制)
 @return UIColor
 */
UIColor *RGBHex(unsigned long rgb);

/**
 从UIColor中获取RGB值及Alpha值
 
 @param color 传入的UIColor
 @return RGB值及Alpha值, 字典格式: @{ @"R" : @"255", @"G" : @"255", @"B" : @"255", @"A" : @"1.0" }
 */
NSDictionary *RGBDictionaryByColor(UIColor *color);


@interface UIColor (HDLHelper)

/**
 UIColor便利构造器
 
 @param rgba 长整型的rgba, 如红色: 0xFF0000FF (十六进制)
 @return UIColor
 */
+ (instancetype)RGBA:(unsigned long)rgba;

/**
 UIColor便利构造器
 
 @param rgb 长整型的rgb, 如红色: 0xFF0000 (十六进制)
 @return UIColor
 */
+ (instancetype)RGB:(unsigned long)rgb;

/**
 从UIColor中获取RGB值及Alpha值
 
 @param color 传入的UIColor
 @return RGB值及Alpha值, 字典格式: @{ @"R" : @"255", @"G" : @"255", @"B" : @"255", @"A" : @"1.0" }
 */
+ (NSDictionary *)getRGBDictionaryByColor:(UIColor *)color;

@end
