//
//  UIDeviceViewController.m
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/8.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import "UIDeviceViewController.h"
#import "HDLHelper.h"

@interface UIDeviceViewController ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *modelLabel;
@property (nonatomic, strong) UILabel *sysNameLabel;
@property (nonatomic, strong) UILabel *sysVersionLabel;
@property (nonatomic, strong) UILabel *modelNameLabel;
@property (nonatomic, strong) UILabel *idfvLabel;

@end

@implementation UIDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    self.nameLabel.text = [NSString stringWithFormat:@"设备名称：%@", UIDevice.deviceName];
    self.modelLabel.text = [NSString stringWithFormat:@"设备类型：%@", UIDevice.deviceModel];
    self.sysNameLabel.text = [NSString stringWithFormat:@"设备系统名称：%@", UIDevice.deviceSysName];
    self.sysVersionLabel.text = [NSString stringWithFormat:@"设备系统版本：%@", UIDevice.deviceSysVersion];
    self.modelNameLabel.text = [NSString stringWithFormat:@"设备机型：%@", UIDevice.deviceModelName];
    self.idfvLabel.text = [NSString stringWithFormat:@"设备identifierForVendor字符串：%@", UIDevice.IDFVString];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor colorWithRed:38 / 255.0 green:155 / 255.0 blue:166 / 255.0 alpha:1.0];
    
    CGFloat x = 20;
    CGFloat y = 120;
    CGFloat w = UIScreen.mainScreen.bounds.size.width - (2 * x);
    CGFloat h = 28;
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    y += (h + 10);
    self.modelLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    y += (h + 10);
    self.sysNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    y += (h + 10);
    self.sysVersionLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    y += (h + 10);
    self.modelNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    y += (h + 10);
    self.idfvLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h + 38)];
    self.idfvLabel.numberOfLines = 0;
    
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.modelLabel];
    [self.view addSubview:self.sysNameLabel];
    [self.view addSubview:self.sysVersionLabel];
    [self.view addSubview:self.modelNameLabel];
    [self.view addSubview:self.idfvLabel];
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
