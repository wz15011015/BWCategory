//
//  UIImageViewController.m
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/11.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import "UIImageViewController.h"
#import "HDLHelper.h"

@interface UIImageViewController ()

@property (nonatomic, strong) UIImageView *sourceImageView; // 原始图片
@property (nonatomic, strong) UIImageView *showImageView; // 处理后的图片

@end

@implementation UIImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    
    // 原始图片
    UIImage *image = [UIImage imageNamed:@"test"];
    
    self.sourceImageView.image = image;
    
    
    // ********* 对图片进行处理 *********
    // 1. 缩放
    // 图片缩放
//    image = [image scaleFillToSize:CGSizeMake(80, 80)];
    
    // 图片缩放 - 等比例
//    image = [image scaleFitToSize:CGSizeMake(80, 80)];
    
    // 图片缩放到指定宽度 - 等比例
//    image = [image scaleFitToWidth:80];
    
    // 图片缩放到指定高度 - 等比例
//    image = [image scaleFitToHeight:80];
    
    
    // 2. 实例化
    // 通过给定的颜色生成图片
//    imageView2.contentMode = UIViewContentModeScaleToFill;
//    image = [UIImage imageWithColor:[UIColor cyanColor]];
    
    // 通过给定颜色和大小生成图片
//    image = [UIImage imageWithColor:[UIColor cyanColor] size:CGSizeMake(80, 80)];
    
    // 通过给定颜色、文字和大小生成图片
//    image = [UIImage imageWithColor:[UIColor cyanColor] size:CGSizeMake(80, 80) title:@"这是图片" titleColor:[UIColor redColor]];
    
    
    // 3. 滤镜 & 模糊化
    // 添加纯色滤镜
    image = [image imageWithTintedColor:UIColor.redColor];
    
    // 高斯模糊
//    image = [image coreBlurWithBlurNumber:0.3];
    
    // 方形模糊
//    image = [image boxBlurWithBlurNumber:0.1];
    
    
    self.showImageView.image = image;
}

- (void)setupUI {
    self.view.backgroundColor = RGB(38, 155, 166);
    
    // 保存按钮
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(screenshotEvent)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    
    CGFloat x = 60;
    CGFloat y = 100;
    CGFloat w = UIScreen.mainScreen.bounds.size.width - (2 * x);
    CGFloat h = w;
    
    self.sourceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.sourceImageView.backgroundColor = [UIColor whiteColor];
    self.sourceImageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.sourceImageView];
    
    y += (h + 20);
    self.showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.showImageView.backgroundColor = [UIColor whiteColor];
    self.showImageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:self.showImageView];
}


#pragma mark - Event

- (void)screenshotEvent {
    // 4. 保存图片
    self.showImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.showImageView.image = [UIImage screenshotImage];

    [self.showImageView.image saveToAlbum:@"DemoScreenshot1" completion:^(UIImage *image, NSError *error) {
        if (!error) {
            NSLog(@"保存屏幕截图完成.");
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
