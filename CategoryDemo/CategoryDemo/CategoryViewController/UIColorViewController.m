//
//  UIColorViewController.m
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/10.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import "UIColorViewController.h"
#import "HDLHelper.h"

@interface UIColorViewController ()

@end

@implementation UIColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = RGB(38, 155, 166);
    
    // 红
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 120, 120, 100)];
    view1.backgroundColor = HSB(0, 255, 255);
    [self.view addSubview:view1];
    
    // 绿
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(150, 120, 120, 100)];
    view2.backgroundColor = RGBAHex(0x00FF00FF); // 0x00FF00FF --> 0,255,0,1.0
    [self.view addSubview:view2];
    
    // 蓝
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(10, 240, 120, 100)];
    view3.backgroundColor = [UIColor RGBA:0x0000FFFF]; // 0x0000FFFF --> 0,0,255,1.0
    [self.view addSubview:view3];
    
    // 蓝
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(150, 240, 120, 100)];
    view4.backgroundColor = [UIColor RGB:0x0000FF]; // 0x0000FF --> 0,0,255
    [self.view addSubview:view4];
    
    
    // 深鲜肉(鲑鱼)色
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(10, 380, 120, 100)];
    view5.backgroundColor = [UIColor RGB:0xE9967A]; // 0xE9967A --> 233,150,122
    [self.view addSubview:view5];
    
    // 从UIColor中获取RGB值及Alpha值
    UIColor *color = [UIColor RGB:0xE9967A];
    NSLog(@"color的RGB值及Alpha值: %@", RGBDictionaryByColor(color));
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
