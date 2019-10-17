//
//  UIAlertControllerViewController.m
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/9.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import "UIAlertControllerViewController.h"
#import "HDLHelper.h"

@interface UIAlertControllerViewController ()

@end

@implementation UIAlertControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor colorWithRed:38 / 255.0 green:155 / 255.0 blue:166 / 255.0 alpha:1.0];
    
    CGFloat x = 90;
    CGFloat y = 120;
    CGFloat w = UIScreen.mainScreen.bounds.size.width - (2 * x);
    CGFloat h = 30;
    
    NSArray *buttons = @[@"Alert 1个按钮",
                         @"Alert 2个按钮",
                         @"Alert带输入框 2个按钮",
                         @"ActionSheet 1个选项",
                         @"ActionSheet 2个选项",
                         @"ActionSheet 3个选项"];
    
    for (int i = 0; i < buttons.count; i++) {
        NSString *buttonTitle = buttons[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 1 + i;
        button.frame = CGRectMake(x, y, w, h);
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        y += (h + 25);
    }
}


#pragma mark - Event

- (void)showEvent:(UIButton *)sender {
    if (sender.tag == 1) {
        [UIAlertController showAlertWithTitle:@"温馨提示"
                                      message:@"这是一个警告弹窗"
                                   firstTitle:@"知道了"
                                 firstHandler:nil
                             toViewController:self];
        
    } else if (sender.tag == 2) {
        [UIAlertController showAlertWithTitle:@"温馨提示"
                                      message:@"这是一个警告弹窗"
                                   firstTitle:@"取消"
                                 firstHandler:nil
                                  secondTitle:@"知道了"
                                secondHandler:^(UIAlertAction * _Nonnull action) {
                                    NSLog(@"事件回调: 进行相应的操作");
                                } toViewController:self];
        
    } else if (sender.tag == 3) {
        [UIAlertController showAlertInputWithTitle:@"温馨提示"
                                           message:@"这是一个输入框弹窗"
                                       placeholder:@"请输入..."
                                          isSecure:NO
                                       cancelTitle:@"取消"
                                     cancelHandler:nil
                                           okTitle:@"确认"
                                         okHandler:^(NSString *text) {
                                             NSLog(@"输入的内容是: %@", text);
                                         } toViewController:self];
        
    } else if (sender.tag == 4) {
        [UIAlertController showSheetWithTitle:@"温馨提示"
                                      message:@"这是一个选择菜单"
                                   firstTitle:@"选项一"
                                 firstHandler:^(UIAlertAction * _Nonnull action) {
                                     NSLog(@"选项一事件回调: 进行相应的操作");
                                 } toViewController:self];
        
    } else if (sender.tag == 5) {
        [UIAlertController showSheetWithTitle:@"温馨提示"
                                      message:@"这是一个选择菜单"
                                   firstTitle:@"选项一"
                                 firstHandler:^(UIAlertAction *action) {
                                     NSLog(@"选项一事件回调: 进行相应的操作");
                                 } secondTitle:@"选项二"
                                secondHandler:^(UIAlertAction *action) {
                                    NSLog(@"选项二事件回调: 进行相应的操作");
                                } toViewController:self];
        
    } else if (sender.tag == 6) {
        [UIAlertController showSheetWithTitle:@"温馨提示"
                                      message:@"这是一个选择菜单"
                                   firstTitle:@"选项一"
                                 firstHandler:^(UIAlertAction *action) {
                                     NSLog(@"选项一事件回调: 进行相应的操作");
                                 } secondTitle:@"选项二"
                                secondHandler:^(UIAlertAction *action) {
                                    NSLog(@"选项二事件回调: 进行相应的操作");
                                } thirdTitle:@"选项三"
                                 thirdHandler:^(UIAlertAction *action) {
                                     NSLog(@"选项三事件回调: 进行相应的操作");
                                 } toViewController:self];
    }
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
