//
//  UIImage+HDLHelper.m
//  CategoryDemo
//
//  Created by ff on 2017/5/3.
//  Copyright © 2017年 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import "UIImage+HDLHelper.h"
#import <Photos/Photos.h>
#import <Accelerate/Accelerate.h>

/**
 * UIImage拓展
 * 1. 保存图片
 * 2. 缩放
 * 3. 实例化
 * 4. 滤镜 & 模糊化
 */

@implementation PHPhotoLibrary (Album)

/**
 保存图片到相册
 
 @param image 要保存的图片
 @param album 相册名称
 @param completionHandler 完成回调
 */
- (void)writeImage:(UIImage *)image toAlbum:(NSString *)album completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler {
    // 权限判断
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus != PHAuthorizationStatusAuthorized) {
        NSLog(@"Error: photo library is not authorized, please authorize.");
        return;
    }
    
    /**
     * PHAsset: 一个PHAsset对象代表一个资源文件,比如一张图片
     * PHAssetCollection: 一个PHAssetCollection对象代表一个相册
     */
    
    // 1. 获取已存在的相册列表,然后判断相册是否已存在
    __block PHAssetCollection *tempCollection = nil;
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:album]) { // 相册已存在,则停止for循环
            tempCollection = collection;
            break;
        }
    }
    
    // 2. 若已存在,则直接保存图片到相册;
    if (tempCollection) {
        
    } else {
        // 3. 若不存在,则先创建相册,再保存图片到相册;
        
        // 3.1 新建一个PHAssetCollectionChangeRequest请求,用来创建一个新相册
        __block NSString *tempCollectionID = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            PHObjectPlaceholder *placeholder = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:album].placeholderForCreatedAssetCollection;
            tempCollectionID = placeholder.localIdentifier;
        } error:nil];
        
        // 3.2 获取新建的相册
        tempCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[tempCollectionID] options:nil].firstObject;
    }
    
    // 4. 保存图片到相册
    // 先存储图片到"相机胶卷",以便后续方便获取图片
    __block NSString *assetID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 新建一个PHAssetCreationRequest对象,保存图片到"相机胶卷"
        PHAssetCreationRequest *request = [PHAssetCreationRequest creationRequestForAssetFromImage:image];
        // 获取图片的字符串标识
        assetID = request.placeholderForCreatedAsset.localIdentifier;
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            // 保存图片到相册
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                // 4.1 根据图片标识从"相机胶卷"中获取图片
                PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil].firstObject;
                
                // 4.2 将图片添加到相册
                PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:tempCollection];
                [request addAssets:@[asset]];
                
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (success) { // 保存图片到相册成功
                    if (completionHandler) {
                        completionHandler(image, nil);
                    }
                } else { // 保存图片到相册失败
                    if (completionHandler) {
                        completionHandler(image, error);
                    }
                }
            }];
            
        } else {
            if (completionHandler) {
                completionHandler(image, error);
            }
        }
    }];
}

@end


@implementation UIImage (Save)

/**
 保存图片到本地

 @param image 要保存的图片
 @param savePath 保存的路径
 */
+ (void)saveImageToLocalWithImage:(UIImage *)image savePath:(NSString *)savePath {
    // 保存图片到本地
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savePath atomically:YES];
    
    NSError *error = nil;
    [imageData writeToFile:savePath options:NSDataWritingFileProtectionComplete error:&error];
    if (error) {
        NSLog(@"writeToFile: error = %@", [error localizedDescription]);
    }
}

/**
 * 保存图片到指定相册
 
 * @param album 相册名
 * @param completion 完成时回调
 */
- (void)saveToAlbum:(NSString *)album completion:(void (^)(UIImage *image, NSError *error))completion {
    [[PHPhotoLibrary sharedPhotoLibrary] writeImage:self toAlbum:album completionHandler:completion];
}

@end


@implementation UIImage (Scale)

/**
 图片缩放
 
 说明：缩放图片到指定大小尺寸, 若size与原图尺寸不成比例,则缩放后图片将变形.

 @param size 指定的大小尺寸
 @return 缩放后的图片
 */
- (UIImage *)scaleFillToSize:(CGSize)size {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制指定大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // 从当前context中创建一个指定大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的图片
    return newImage;
}

/**
 图片缩放 - 等比例

 @param size 指定的大小尺寸
 @return 缩放后的图片
 */
- (UIImage *)scaleFitToSize:(CGSize)size {
    UIImage *newImage = nil;
    CGFloat width = self.size.width; // original width
    CGFloat height = self.size.height; // original height
    
    CGFloat scaleFactorWidth = 0.0;
    CGFloat scaleFactorHeight = 0.0;
    CGFloat scaledWidth = size.width;
    CGFloat scaledHeight = size.height;
    
    scaleFactorWidth = width / size.width;
    scaleFactorHeight = height / size.height;
    if (scaleFactorHeight > scaleFactorWidth) {
        scaledWidth = width / scaleFactorHeight;
    } else {
        scaledHeight = height / scaleFactorWidth;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(scaledWidth, scaledHeight));
    [self drawInRect:CGRectMake(0, 0, scaledWidth, scaledHeight)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 图片缩放到指定宽度 - 等比例
 
 @param toWidth 指定的宽度
 @return 缩放后的图片
 */
- (UIImage *)scaleFitToWidth:(CGFloat)toWidth {
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    long targetWidth = toWidth;
    long targetHeight = (toWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [self drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 图片缩放到指定高度 - 等比例
 
 @param toHeight 指定的高度
 @return 缩放后的图片
 */
- (UIImage *)scaleFitToHeight:(CGFloat)toHeight {
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    long targetHeight = toHeight;
    long targetWidth = (toHeight / height) * width;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [self drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 等比例压缩图片到指定kb

 @param image 原始图片
 @param kb 指定kb
 @return 压缩后的图片
 */
+ (UIImage *)scaleImage:(UIImage *)image toKb:(NSInteger)kb {
    if (!image) {
        return image;
    }
    if (kb < 1) {
        return image;
    }
    
    kb *= 1024;
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > kb && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
//    NSLog(@"当前大小: %f kb", (float)[imageData length] / 1024.0f);
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}

@end


@implementation UIImage (Instance)

/**
 改变图片的朝向,使其为默认朝向(UIImageOrientationUp)

 @param aImage 原始图片
 @return 改变朝向后的图片
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp) {
        return aImage;
    }
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.height, aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.width, aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;
}

/**
 通过给定的颜色生成图片

 若UIImageView的contentMode设置为: UIViewContentModeCenter,
 则显示为一个点,因为默认大小为(1, 1).
 
 @param color 给定的颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 通过给定颜色和大小生成图片

 @param color 给定的颜色
 @param size 给定的大小
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, CGRectMake(0, 0, size.width, size.height));
    
    // 填充颜色
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    // 在context上绘制
    CGContextFillPath(context);
    
    // 把当前context的内容输出成一个UIImage图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 上下文栈pop出创建的context
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 通过给定颜色、文字和大小生成图片

 @param color 给定的颜色
 @param size 给定的大小
 @param title 文字
 @param titleColor 文字颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size title:(NSString *)title titleColor:(UIColor *)titleColor {
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, size.width, size.height);
    label.backgroundColor = color;
    label.text = title;
    label.textColor = titleColor;
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 文字转换成图片
    [label.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 从view中生成图片
 
 @param view 视图
 @return 截取视图的图片
 */
+ (UIImage *)shotImageFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 把当前的整个画面导入到context中，然后通过context输出UIImage，这样就可以把整个屏幕转化为图片
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 * 屏幕截图 (不包含状态栏)
 
 * @return 屏幕截图
 */
+ (UIImage *)screenshotImage {
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [view drawViewHierarchyInRect:CGRectMake(0, 0, size.width, size.height) afterScreenUpdates:NO];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 * 屏幕截屏 (包含状态栏)
 
 * @return 屏幕截屏
 */
+ (UIImage *)screenshotFullImage {
//    UIWindow *statusBar = nil;
//    UIApplication *application = [UIApplication sharedApplication];
//    if ([application respondsToSelector:NSSelectorFromString(@"statusBarWindow")]) {
//        statusBar = [application valueForKey:@"statusBarWindow"];
//    }
//
//    CGSize size = [UIScreen mainScreen].bounds.size;
//
//    /** 创建image上下文 */
//    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    /** 截屏 */
//    for (UIWindow *window in [UIApplication sharedApplication].windows) {
//        if ([window respondsToSelector:@selector(screen)] && window.screen == [UIScreen mainScreen]) {
//            continue;
//        }
//
//        /** 绘制 */
//        CGContextSaveGState(context);
//        CGContextTranslateCTM(context, window.center.x, window.center.y);
//        CGContextConcatCTM(context, window.transform);
//        CGContextTranslateCTM(context, - window.bounds.size.width * window.layer.anchorPoint.x, - window.bounds.size.height * window.layer.anchorPoint.y);
//        [window.layer renderInContext:context];
//        CGContextRestoreGState(context);
//    }
//
//    /** 状态栏处理 */
//    [statusBar drawViewHierarchyInRect:CGRectMake(0, 0, size.width, size.height) afterScreenUpdates:NO];
//
//    /** 生成图片 */
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return image;
    
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    UIView *view = [UIApplication sharedApplication].keyWindow;
    [view drawViewHierarchyInRect:CGRectMake(0, 0, size.width, size.height) afterScreenUpdates:NO];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 将图片转成圆形图片,并加边框

 @param sourceImage 原始图片
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return 圆形图片
 */
+ (UIImage *)circleImageWithImage:(UIImage *)sourceImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    // 1. 开启上下文
    CGFloat imageWidth = sourceImage.size.width + 2 * borderWidth;
    CGFloat imageHeigh = sourceImage.size.height + 2 * borderWidth;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeigh), NO, 0);
    // 2. 获取上下文
    UIGraphicsGetCurrentContext();
    // 3. 画圆
    CGFloat radius = sourceImage.size.width < sourceImage.size.height ? sourceImage.size.width * 0.5 : sourceImage.size.height * 0.5;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageWidth * 0.5, imageHeigh * 0.5) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    bezierPath.lineWidth = borderWidth;
    [borderColor setStroke];
    [bezierPath stroke];
    // 4. 使用BezierPath进行剪切
    [bezierPath addClip];
    // 5. 画图
    [sourceImage drawInRect:CGRectMake(borderWidth, borderWidth, sourceImage.size.width, sourceImage.size.height)];
    // 6. 从内存中创建新图片对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 7. 结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 从图片中指定的位置大小截取图片的一部分

 @param bounds 要截取的区域
 @return 截取的图片
 */
- (UIImage *)clipToBounds:(CGRect)bounds {
    // 将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [self CGImage];
    
    // 按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, bounds);
    
    // 将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    
    // 返回剪裁后的图片
    return newImage;
}

@end


@implementation UIImage (Render)

/**
 系统方法添加滤镜

 @param tintColor 滤镜颜色
 @param blendMode 混合模式
 @return 添加滤镜后的图片
 */
- (UIImage *)imageWithTintedColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode {
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    UIRectFill(bounds);
    
    // kCGBlendModeOverlay能保留灰度信息,kCGBlendModeDestinationIn能保留透明度信息
    // Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

/**
 系统方法添加纯色滤镜

 @param tintColor 滤镜颜色
 @return 纯色滤镜过滤后的图片
 */
- (UIImage *)imageWithTintedColor:(UIColor *)tintColor {
    return [self imageWithTintedColor:tintColor blendMode:kCGBlendModeLuminosity];
}

/**
 高斯模糊,毛玻璃效果 (使用Core Image的滤镜进行模糊处理)
 
 @param blur 取值范围: 0.0 ~ 1.0
 @return 模糊化的图片
 */
- (UIImage *)coreBlurWithBlurNumber:(CGFloat)blur {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
    
    // 设置filter
    blur = blur < 0.f ? 0 : (blur > 1.f ? 10 : blur * 10); // blur范围: 0.0 ~ 1.0
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(blur) forKey:kCIInputRadiusKey];
    
    // 模糊图片
    CIImage *outputImage = [filter valueForKey:kCIOutputImageKey];
    CGRect extent = [outputImage extent];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:extent];
    UIImage *blurImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    // 截取图片
    CGSize size = self.size, xsize = extent.size;
    CGRect bounds = CGRectMake((xsize.width - size.width) / 2, (xsize.height - size.height) / 2, size.width, size.height);

    return [blurImage clipToBounds:bounds];
}

/**
 方形模糊

 @param blur 取值范围: 0.0 ~ 1.0
 @return 模糊化的图片
 */
- (UIImage *)boxBlurWithBlurNumber:(CGFloat)blur {
    if (blur == 0) {
        return self.copy;
    }
    blur = blur < 0.f ? 0.f : (blur > 1.f ? 1.f : blur);
    
    int box_size = (int)(blur * 40);
    box_size = box_size - (box_size % 2) + 1;
    
    /**
     * 位图：由一个个像素点组成的图像
     * 图片像素点个数：图片宽高的乘积
     * 一个像素点的大小：4个字节（存放RGBA值，每一分量占1个字节）
     * 图片大小：像素点个数乘以4个字节，即: size = w * h * 4
     */
    
    CGImageRef img = self.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    // 从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    // 设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if (pixelBuffer == NULL) {
        NSLog(@"No pixelbuffer");
        return nil;
    }
    // 输出缓冲
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, box_size, box_size, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
        return nil;
    }
    
    // 创建颜色空间
    CGColorSpaceRef color_space = CGColorSpaceCreateDeviceRGB();
    
    /**
     * 创建绘制当前图片的上下文
     *
     * data - 所需要的内存空间,传nil时会自动分配
     * width / height - 当前画布的宽/高
     * bitsPerComponent - 每个颜色分量的大小, RGBA每一个分量占1个字节
     * bytesPerRow - 每一行使用的字节数 (4 * width)
     * bitmapInfo - RGBA绘制的顺序
     */
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, color_space, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    // clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(color_space);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(color_space);
    CGImageRelease(imageRef);
    
    return returnImage;
}

@end
