//
//  UIAlertController+HDLHelper.m
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/9.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import "UIAlertController+HDLHelper.h"

@implementation UIAlertController (HDLHelper)

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
          toViewController:(UIViewController *)controller {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // 修改title的显示,包括颜色和字体
//    if (title) {
//        NSMutableAttributedString *alertTitle = [[NSMutableAttributedString alloc] initWithString:title];
//        [alertTitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, title.length)];
//        [alertTitle addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, title.length)];
//        [alert setValue:alertTitle forKey:@"attributedTitle"];
//    }
    
    // 修改message的显示,包括颜色和字体
//    if (message) {
//        NSMutableAttributedString *alertMessage = [[NSMutableAttributedString alloc] initWithString:message];
//        [alertMessage addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, message.length)];
//        [alertMessage addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, message.length)];
//        [alert setValue:alertMessage forKey:@"attributedMessage"];
//    }
    
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:firstTitle style:UIAlertActionStyleCancel handler:firstHandler];
    
    // 修改按钮标题颜色
//    [firstAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    
    [alert addAction:firstAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [controller presentViewController:alert animated:YES completion:nil];
    });
}

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
          toViewController:(UIViewController *)controller {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:firstTitle style:UIAlertActionStyleCancel handler:firstHandler];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:secondTitle style:UIAlertActionStyleDefault handler:secondHandler];
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [controller presentViewController:alert animated:YES completion:nil];
    });
}

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
               toViewController:(UIViewController *)controller {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // 添加输入框
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeholder;
        textField.secureTextEntry = isSecure;
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelHandler];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *text = alert.textFields.firstObject.text;
        if (okHandler) {
            okHandler(text);
        }
    }];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [controller presentViewController:alert animated:YES completion:nil];
    });
}


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
          toViewController:(UIViewController *)controller {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:firstTitle style:UIAlertActionStyleDefault handler:firstHandler];
    [alert addAction:cancelAction];
    [alert addAction:firstAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [controller presentViewController:alert animated:YES completion:nil];
    });
}

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
          toViewController:(UIViewController *)controller {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:firstTitle style:UIAlertActionStyleDefault handler:firstHandler];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:secondTitle style:UIAlertActionStyleDefault handler:secondHandler];
    [alert addAction:cancelAction];
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [controller presentViewController:alert animated:YES completion:nil];
    });
}

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
          toViewController:(UIViewController *)controller {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:firstTitle style:UIAlertActionStyleDefault handler:firstHandler];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:secondTitle style:UIAlertActionStyleDefault handler:secondHandler];
    UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:thirdTitle style:UIAlertActionStyleDefault handler:thirdHandler];
    [alert addAction:cancelAction];
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    [alert addAction:thirdAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [controller presentViewController:alert animated:YES completion:nil];
    });
}

@end
