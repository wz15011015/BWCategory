//
//  NSStringViewController.m
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/9.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import "NSStringViewController.h"
#import "HDLHelper.h"

@interface NSStringViewController ()

@end

@implementation NSStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self stringEncryptor];
    [self stringURL];
    [self stringValidator];
    [self stringFilter];
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor colorWithRed:38 / 255.0 green:155 / 255.0 blue:166 / 255.0 alpha:1.0];
}


#pragma mark - 加密

- (void)stringEncryptor {
    NSString *plainText = @"Tonight 22:00:00";
    NSLog(@"加密(SHA1): %@", [plainText SHA1]);
    NSLog(@"加密(SHA256): %@", [plainText SHA256]);
    NSLog(@"加密(SHA512): %@", [plainText SHA512]);
    NSLog(@"加密(MD5): %@", [plainText MD5]);
}


#pragma mark - URL编码

- (void)stringURL {
    NSString *str2 = @"https://www.baidu.com/s?wd=URL编码";
    NSLog(@"对URL中的中文进行转码: %@", [str2 URLEncodedString]);
    
    NSString *str3 = @"https://www.baidu.com/s?wd=URL%E7%BC%96%E7%A0%81";
    NSLog(@"URL解码: %@", [str3 URLDecodedString]);
    
    NSString *str4 = @"中文转换成拼音";
    NSLog(@"中文转换成拼音: %@", [str4 pinyin]);
}


#pragma mark - 验证器

- (void)stringValidator {
    NSString *str1 = @"232994@qq.com";
    NSLog(@"%@ 是否为邮箱地址: %@", str1, [str1 isEmailAddress] ? @"是" : @"否");
    
    NSString *str2 = @"15620633049";
    NSLog(@"%@ 是否为中国内地的手机号码: %@", str2, [str2 isPhoneNumber] ? @"是" : @"否");
    
    NSString *str3 = @"浙B10ES1";
    NSLog(@"%@ 是否为正确的车牌号: %@", str3, [str3 isCarNumber] ? @"是" : @"否");
}


#pragma mark - 过滤器

- (void)stringFilter {
    NSString *str1 = @" Do something cool. ";
    NSLog(@"过滤首尾的空格: [%@]", [str1 trimWhitespace]);
    
    NSString *str2 = @" \nDo something\ncool.\n ";
    NSLog(@"过滤首尾的空格和换行: [%@]", [str2 trimWhitespaceAndNewline]);
    
    NSString *str3 = @" Do something cool. ";
    NSLog(@"过滤所有的空格: [%@]", [str3 trimAllWhitespace]);
    
    NSString *str4 = @" \nDo something\ncool.\n ";
    NSLog(@"过滤所有的空格和换行: [%@]", [str4 trimAllWhitespaceAndNewline]);
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
