//
//  UIColor+HDLHelper.m
//  CategoryDemo
//
//  Created by Shaojun Han on 3/7/16.
//  Copyright © 2016 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import "UIColor+HDLHelper.h"

/**
 构造UIColor (HSB)

 @param hue 色度, 0 - 255
 @param saturation 饱和度, 0 - 255
 @param brightness 亮度, 0 - 255
 @param alpha 透明度, 0.0 - 1.0
 @return UIColor
 */
UIColor *HSBA(UInt8 hue, UInt8 saturation, UInt8 brightness, CGFloat alpha) {
    return [UIColor colorWithHue:hue / 255.0 saturation:saturation / 255.0 brightness:brightness / 255.0 alpha:alpha];
}

/**
 构造UIColor (HSB)

 @param hue 色度, 0 - 255
 @param saturation 饱和度, 0 - 255
 @param brightness 亮度, 0 - 255
 @return UIColor
 */
UIColor *HSB(UInt8 hue, UInt8 saturation, UInt8 brightness) {
    return HSBA(hue, saturation, brightness, 1.0);
}

/**
 构造UIColor (RGB)

 @param red 红色, 0 - 255
 @param green 绿色, 0 - 255
 @param blue 蓝色, 0 - 255
 @param alpha 透明度, 0.0 - 1.0
 @return UIColor
 */
UIColor *RGBA(UInt8 red, UInt8 green, UInt8 blue, CGFloat alpha) {
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

/**
 构造UIColor (RGB)

 @param red 红色, 0 - 255
 @param green 绿色, 0 - 255
 @param blue 蓝色, 0 - 255
 @return UIColor
 */
UIColor *RGB(UInt8 red, UInt8 green, UInt8 blue) {
    return RGBA(red, green, blue, 1.0);
}

/**
 构造UIColor (RGB)

 @param rgba 长整型的rgb, 如红色: 0xFF0000FF (十六进制)
 @return UIColor
 */
UIColor *RGBAHex(unsigned long rgba) {
    unsigned int red = (rgba >> 24) & 0xFF;
    unsigned int green = (rgba >> 16) & 0xFF;
    unsigned int blue = (rgba >> 8) & 0xFF;
    unsigned int alpha = (rgba >> 0) & 0xFF;
    return RGBA(red, green, blue, alpha / 255.0);
}

/**
 构造UIColor (RGB)

 @param rgb 长整型的rgb, 如红色: 0xFF0000 (十六进制)
 @return UIColor
 */
UIColor *RGBHex(unsigned long rgb) {
    unsigned int red = (rgb >> 16) & 0xFF;
    unsigned int green = (rgb >> 8) & 0xFF;
    unsigned int blue = (rgb >> 0) & 0xFF;
    return RGB(red, green, blue);
}

/**
 从UIColor中获取RGB值及Alpha值
 
 @param color 传入的UIColor
 @return RGB值及Alpha值, 字典格式: @{ @"R" : @"255", @"G" : @"255", @"B" : @"255", @"A" : @"1.0" }
 */
NSDictionary *RGBDictionaryByColor(UIColor *color) {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    if ([UIColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [color getRed:&r green:&g blue:&b alpha:&a];
    } else {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    
    UInt8 red = (UInt8)(r * 255);
    UInt8 green = (UInt8)(g * 255);
    UInt8 blue = (UInt8)(b * 255);
    return @{ @"R" : @(red), @"G" : @(green), @"B" : @(blue), @"A" : @(a) };
}


@implementation UIColor (HDLHelper)

/**
 UIColor便利构造器

 @param rgba 长整型的rgba, 如红色: 0xFF0000FF (十六进制)
 @return UIColor
 */
+ (instancetype)RGBA:(unsigned long)rgba {
    unsigned int red = (rgba >> 24) & 0xFF;
    unsigned int green = (rgba >> 16) & 0xFF;
    unsigned int blue = (rgba >> 8) & 0xFF;
    unsigned int alpha = (rgba >> 0) & 0xFF;
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha / 255.0];
}

/**
 UIColor便利构造器

 @param rgb 长整型的rgb, 如红色: 0xFF0000 (十六进制)
 @return UIColor
 */
+ (instancetype)RGB:(unsigned long)rgb {
    unsigned int red = (rgb >> 16) & 0xFF;
    unsigned int green = (rgb >> 8) & 0xFF;
    unsigned int blue = (rgb >> 0) & 0xFF;
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
}

/**
 从UIColor中获取RGB值及Alpha值
 
 @param color 传入的UIColor
 @return RGB值及Alpha值, 字典格式: @{ @"R" : @"255", @"G" : @"255", @"B" : @"255", @"A" : @"1.0" }
 */
+ (NSDictionary *)getRGBDictionaryByColor:(UIColor *)color {
    CGFloat r = 0, g = 0, b = 0, a = 0;
    if ([UIColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [color getRed:&r green:&g blue:&b alpha:&a];
    } else {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    
    UInt8 red = (UInt8)(r * 255);
    UInt8 green = (UInt8)(g * 255);
    UInt8 blue = (UInt8)(b * 255);
    return @{ @"R" : @(red), @"G" : @(green), @"B" : @(blue), @"A" : @(a) };
}

@end
