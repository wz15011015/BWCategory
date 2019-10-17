//
//  UIImage+HDLHelper.h
//  CategoryDemo
//
//  Created by ff on 2017/5/3.
//  Copyright © 2017年 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * UIImage拓展
 * 1. 保存图片
 * 2. 缩放
 * 3. 实例化
 * 4. 滤镜 & 模糊化
 */

@interface UIImage (Save)

/**
 保存图片到本地
 
 @param image 要保存的图片
 @param savePath 保存的路径
 */
+ (void)saveImageToLocalWithImage:(UIImage *)image savePath:(NSString *)savePath;

/**
 * 保存图片到指定相册
 
 * @param album 相册名
 * @param completion 完成时回调
 */
- (void)saveToAlbum:(NSString *)album completion:(void (^)(UIImage *image, NSError *error))completion;

@end


@interface UIImage (Scale)

/**
 图片缩放
 
 说明：缩放图片到指定大小尺寸, 若size与原图尺寸不成比例,则缩放后图片将变形.
 
 @param size 指定的大小尺寸
 @return 缩放后的图片
 */
- (UIImage *)scaleFillToSize:(CGSize)size;

/**
 图片缩放 - 等比例
 
 @param size 指定的大小尺寸
 @return 缩放后的图片
 */
- (UIImage *)scaleFitToSize:(CGSize)size;

/**
 图片缩放到指定宽度 - 等比例
 
 @param toWidth 指定的宽度
 @return 缩放后的图片
 */
- (UIImage *)scaleFitToWidth:(CGFloat)toWidth;

/**
 图片缩放到指定高度 - 等比例
 
 @param toHeight 指定的高度
 @return 缩放后的图片
 */
- (UIImage *)scaleFitToHeight:(CGFloat)toHeight;

/**
 等比例压缩图片到指定kb
 
 @param image 原始图片
 @param kb 指定kb
 @return 压缩后的图片
 */
+ (UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb;

@end


@interface UIImage (Instance)

/**
 改变图片的朝向,使其为默认朝向(UIImageOrientationUp)
 
 @param aImage 原始图片
 @return 改变朝向后的图片
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

/**
 通过给定的颜色生成图片
 
 若UIImageView的contentMode设置为: UIViewContentModeCenter,
 则显示为一个点,因为默认大小为(1, 1).
 
 @param color 给定的颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 通过给定颜色和大小生成图片
 
 @param color 给定的颜色
 @param size 给定的大小
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 通过给定颜色、文字和大小生成图片
 
 @param color 给定的颜色
 @param size 给定的大小
 @param title 文字
 @param titleColor 文字颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size title:(NSString *)title titleColor:(UIColor *)titleColor;

/**
 从view中生成图片

 @param view 视图
 @return 截取视图的图片
 */
+ (UIImage *)shotImageFromView:(UIView *)view;

/**
 * 屏幕截图 (不包含状态栏)
 
 * @return 屏幕截图
 */
+ (UIImage *)screenshotImage;

/**
 * 屏幕截屏 (包含状态栏)
 
 * @return 屏幕截屏
 */
+ (UIImage *)screenshotFullImage;

/**
 将图片转成圆形图片,并加边框
 
 @param sourceImage 原始图片
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return 圆形图片
 */
+ (UIImage *)circleImageWithImage:(UIImage *)sourceImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 从图片中指定的位置大小截取图片的一部分
 
 @param bounds 要截取的区域
 @return 截取的图片
 */
- (UIImage *)clipToBounds:(CGRect)bounds;

@end


@interface UIImage (Render)

/**
 系统方法添加纯色滤镜
 
 @param tintColor 滤镜颜色
 @return 纯色滤镜过滤后的图片
 */
- (UIImage *)imageWithTintedColor:(UIColor *)tintColor;

/**
 高斯模糊,毛玻璃效果 (使用Core Image的滤镜进行模糊处理)
 
 @param blur 取值范围: 0.0 ~ 1.0
 @return 模糊化的图片
 */
- (UIImage *)coreBlurWithBlurNumber:(CGFloat)blur;

/**
 方形模糊
 
 @param blur 取值范围: 0.0 ~ 1.0
 @return 模糊化的图片
 */
- (UIImage *)boxBlurWithBlurNumber:(CGFloat)blur;

@end

