//
//  NSDataViewController.m
//  CategoryDemo
//
//  Created by hadlinks on 2020/3/23.
//  Copyright © 2020 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import "NSDataViewController.h"
#import "HDLHelper.h"

@interface NSDataViewController ()

@property (nonatomic, strong) UILabel *sourceStrLabel; // 源字符串
@property (nonatomic, strong) UILabel *base64EncodeLabel; // Base64编码
@property (nonatomic, strong) UILabel *base64DecodeLabel; // Base64解码
@property (nonatomic, strong) UILabel *AESEncryptLabel; // AES加密
@property (nonatomic, strong) UILabel *AESDecryptLabel; // AES解密
@property (nonatomic, strong) UILabel *AESEncryptBase64Label; // AES+Base64 加密
@property (nonatomic, strong) UILabel *AESDecryptBase64Label; // AES+Base64 解密

@property (nonatomic, strong) UILabel *MD5Label;

@end

@implementation NSDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    
    NSString *sourceStr = @"BTStudio CategoryDemo"; // 源字符串
    // 针对对中文加密失败的情况,需要先将字符串转换为base64字符串,然后再进行加密
//    sourceStr = @"奔腾工作室";
    NSString *key = @"31415926"; // 密钥
    
    NSString *base64Encode = [sourceStr base64Encode];
    NSString *base64Decode = [base64Encode base64Decode];
    NSString *AESEncrypt = [sourceStr AES256EncryptWithKey:key enableBase64Encode:NO];
    NSString *AESDecrypt = [AESEncrypt AES256DecryptWithKey:key enableBase64Encode:NO];
    NSString *AESEncryptBase64 = [sourceStr AES256EncryptWithKey:key];
    NSString *AESDecryptBase64 = [AESEncryptBase64 AES256DecryptWithKey:key];
    NSLog(@"1. Base64编码:\n%@", base64Encode);
    NSLog(@"2. Base64解码:\n%@", base64Decode);
    NSLog(@"3. AES256加密:\n%@", AESEncrypt);
    NSLog(@"4. AES256解密:\n%@", AESDecrypt);
    NSLog(@"5. AES256+Base64加密:\n%@", AESEncryptBase64);
    NSLog(@"6. AES256+Base64解密:\n%@", AESDecryptBase64);
    
    self.sourceStrLabel.text = [NSString stringWithFormat:@"要加密的字符串:\n%@", sourceStr];
    
    self.base64EncodeLabel.text = [NSString stringWithFormat:@"1. Base64编码:\n%@", base64Encode];
    self.base64DecodeLabel.text = [NSString stringWithFormat:@"2. Base64解码:\n%@", base64Decode];
    self.AESEncryptLabel.text = [NSString stringWithFormat:@"3. AES256加密:\n%@", AESEncrypt];
    self.AESDecryptLabel.text = [NSString stringWithFormat:@"4. AES256解密:\n%@", AESDecrypt];
    self.AESEncryptBase64Label.text = [NSString stringWithFormat:@"5. AES256+Base64加密:\n%@", AESEncryptBase64];
    self.AESDecryptBase64Label.text = [NSString stringWithFormat:@"6. AES256+Base64解密:\n%@", AESDecryptBase64];
}


- (void)setupUI {
    self.view.backgroundColor = [UIColor colorWithRed:38 / 255.0 green:155 / 255.0 blue:166 / 255.0 alpha:1.0];
    
    CGFloat x = 20;
    CGFloat y = 95;
    CGFloat w = UIScreen.mainScreen.bounds.size.width - (2 * x);
    CGFloat h = 28;
    
    self.sourceStrLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h + 20)];
    self.sourceStrLabel.numberOfLines = 0;
    
    y += (h + 40);
    self.base64EncodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.base64EncodeLabel.numberOfLines = 0;
    self.base64EncodeLabel.minimumScaleFactor = 0.5;
    self.base64EncodeLabel.adjustsFontSizeToFitWidth = YES;
    
    y += (h + 10);
    self.base64DecodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.base64DecodeLabel.numberOfLines = 0;
    self.base64DecodeLabel.minimumScaleFactor = 0.5;
    self.base64DecodeLabel.adjustsFontSizeToFitWidth = YES;
    
    y += (h + 10);
    self.AESEncryptLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.AESEncryptLabel.numberOfLines = 0;
    self.AESEncryptLabel.minimumScaleFactor = 0.5;
    self.AESEncryptLabel.adjustsFontSizeToFitWidth = YES;
    
    y += (h + 10);
    self.AESDecryptLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.AESDecryptLabel.numberOfLines = 0;
    self.AESDecryptLabel.minimumScaleFactor = 0.5;
    self.AESDecryptLabel.adjustsFontSizeToFitWidth = YES;
    
    y += (h + 10);
    self.AESEncryptBase64Label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h + 38)];
    self.AESEncryptBase64Label.numberOfLines = 0;
    self.AESEncryptBase64Label.minimumScaleFactor = 0.5;
    self.AESEncryptBase64Label.adjustsFontSizeToFitWidth = YES;
    
    y += (h + 34);
    self.AESDecryptBase64Label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h + 38)];
    self.AESDecryptBase64Label.numberOfLines = 0;
    self.AESDecryptBase64Label.minimumScaleFactor = 0.5;
    self.AESDecryptBase64Label.adjustsFontSizeToFitWidth = YES;
    
    
    [self.view addSubview:self.sourceStrLabel];
    [self.view addSubview:self.base64EncodeLabel];
    [self.view addSubview:self.base64DecodeLabel];
    [self.view addSubview:self.AESEncryptLabel];
    [self.view addSubview:self.AESDecryptLabel];
    [self.view addSubview:self.AESEncryptBase64Label];
    [self.view addSubview:self.AESDecryptBase64Label];
}

@end
