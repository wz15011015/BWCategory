//
//  UIAlertController+HDLHelper.h
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/9.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertHandler)(UIAlertAction *action);
typedef void(^AlertInputHandler)(NSString *text);


@interface UIAlertController (HDLHelper)

#pragma mark - Alert

/**
 警告弹窗: 1个按钮 (OK)
 
 @param title 标题
 @param message 内容
 @param firstTitle 按钮标题
 @param firstHandler 按钮事件回调
 @param controller 展现警告弹窗的控制器
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                firstTitle:(NSString *)firstTitle
              firstHandler:(AlertHandler)firstHandler
          toViewController:(UIViewController *)controller;

/**
 警告弹窗: 2个按钮 (Cancel + OK)
 
 @param title 标题
 @param message 内容
 @param firstTitle 按钮1标题
 @param firstHandler 按钮1事件回调
 @param secondTitle 按钮2标题
 @param secondHandler 按钮2事件回调
 @param controller 展现警告弹窗的控制器
 */
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                firstTitle:(NSString *)firstTitle
              firstHandler:(AlertHandler)firstHandler
               secondTitle:(NSString *)secondTitle
             secondHandler:(AlertHandler)secondHandler
          toViewController:(UIViewController *)controller;

/**
 警告弹窗: 输入框 + 2个按钮 (Cancel + OK)
 
 @param title 标题
 @param message 内容
 @param placeholder 输入框占位文字
 @param isSecure 是否为安全输入模式
 @param cancelTitle Cancel按钮标题
 @param cancelHandler Cancel按钮事件回调
 @param okTitle Ok按钮标题
 @param okHandler Ok按钮事件回调
 @param controller 展现警告弹窗的控制器
 */
+ (void)showAlertInputWithTitle:(NSString *)title
                        message:(NSString *)message
                    placeholder:(NSString *)placeholder
                       isSecure:(BOOL)isSecure
                    cancelTitle:(NSString *)cancelTitle
                  cancelHandler:(AlertHandler)cancelHandler
                        okTitle:(NSString *)okTitle
                      okHandler:(AlertInputHandler)okHandler
               toViewController:(UIViewController *)controller;


#pragma mark - ActionSheet

/**
 选择菜单: 1个选项 + 取消按钮
 
 @param title 标题
 @param message 内容
 @param firstTitle 选项1标题
 @param firstHandler 选项1事件回调
 @param controller 展现选择菜单的控制器
 */
+ (void)showSheetWithTitle:(NSString *)title
                   message:(NSString *)message
                firstTitle:(NSString *)firstTitle
              firstHandler:(AlertHandler)firstHandler
          toViewController:(UIViewController *)controller;

/**
 选择菜单: 2个选项 + 取消按钮
 
 @param title 标题
 @param message 内容
 @param firstTitle 选项1标题
 @param firstHandler 选项1事件回调
 @param secondTitle 选项2标题
 @param secondHandler 选项2事件回调
 @param controller 展现选择菜单的控制器
 */
+ (void)showSheetWithTitle:(NSString *)title
                   message:(NSString *)message
                firstTitle:(NSString *)firstTitle
              firstHandler:(AlertHandler)firstHandler
               secondTitle:(NSString *)secondTitle
             secondHandler:(AlertHandler)secondHandler
          toViewController:(UIViewController *)controller;

/**
 选择菜单: 3个选项 + 取消按钮
 
 @param title 标题
 @param message 内容
 @param firstTitle 选项1标题
 @param firstHandler 选项1事件回调
 @param secondTitle 选项2标题
 @param secondHandler 选项2事件回调
 @param thirdTitle 选项3标题
 @param thirdHandler 选项3事件回调
 @param controller 展现选择菜单的控制器
 */
+ (void)showSheetWithTitle:(NSString *)title
                   message:(NSString *)message
                firstTitle:(NSString *)firstTitle
              firstHandler:(AlertHandler)firstHandler
               secondTitle:(NSString *)secondTitle
             secondHandler:(AlertHandler)secondHandler
                thirdTitle:(NSString *)thirdTitle
              thirdHandler:(AlertHandler)thirdHandler
          toViewController:(UIViewController *)controller;

@end
