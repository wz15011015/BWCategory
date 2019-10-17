//
//  NSBundleViewController.m
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/8.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import "NSBundleViewController.h"
#import "HDLHelper.h"

@interface NSBundleViewController ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UILabel *buildVersionLabel;

@end

@implementation NSBundleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    self.nameLabel.text = [NSString stringWithFormat:@"App名称：%@", NSBundle.appName];
    self.versionLabel.text = [NSString stringWithFormat:@"App版本号：%@", NSBundle.appVersion];
    self.buildVersionLabel.text = [NSString stringWithFormat:@"App Build版本号：%@", NSBundle.appBuildVersion];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor colorWithRed:38 / 255.0 green:155 / 255.0 blue:166 / 255.0 alpha:1.0];
    
    CGFloat x = 20;
    CGFloat y = 120;
    CGFloat w = UIScreen.mainScreen.bounds.size.width - (2 * x);
    CGFloat h = 28;
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    y += (h + 10);
    self.versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    y += (h + 10);
    self.buildVersionLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.versionLabel];
    [self.view addSubview:self.buildVersionLabel];
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
