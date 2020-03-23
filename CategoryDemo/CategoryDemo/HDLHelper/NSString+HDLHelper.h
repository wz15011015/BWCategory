//
//  NSString+HDLHelper.h
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/8.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * NSString拓展
 * 1. 加密
 * 2. UUID等App信息
 * 3. URL编码
 * 3. 验证器
 * 4. 过滤器, 过滤空格、换行符等等
 */

@interface NSString (HDLHelper)

@end


@interface NSString (Encryptor)

/// 对字符串进行Base64编码
- (NSString *)base64Encode;

/// 对Base64编码字符串进行解码
- (NSString *)base64Decode;

/**
 * SHA1摘要算法
 
 * @return 十六进制形式的摘要字符串(大写)
 */
- (NSString *)SHA1;

/**
 * SHA256摘要算法
 
 * @return 十六进制形式的摘要字符串(大写)
 */
- (NSString *)SHA256;

/**
 * SHA512摘要算法
 
 * @return 十六进制形式的摘要字符串(大写)
 */
- (NSString *)SHA512;

/**
 * MD5信息摘要算法
 
 * @return 十六进制形式的摘要字符串(大写)
 */
- (NSString *)MD5;

/// 加密
/// @param key 密钥
/// @param enable 加密前是否对字符串进行Base64编码
- (NSString *)AES256EncryptWithKey:(NSString *)key enableBase64Encode:(BOOL)enable;

/// 解密
/// @param key 密钥
/// @param enable 解密完成后是否对结果进行Base64解码
- (NSString *)AES256DecryptWithKey:(NSString *)key enableBase64Encode:(BOOL)enable;

/// 加密
/// @param key 密钥
- (NSString *)AES256EncryptWithKey:(NSString *)key;

/// 解密
/// @param key 密钥
- (NSString *)AES256DecryptWithKey:(NSString *)key;

@end


@interface NSString (Info)

/**
 获取UUID字符串
 
 每次调用都会返回一个新的唯一标示符.
 
 @return UUID字符串
 */
+ (NSString *)UUIDString;

/**
 * 得到Document路径
 */
+ (NSString *)documentDirectory;

/**
 * 以 用户名 + UUID 命名
 * 说明：可用于命名图片名称
 */
+ (NSString *)imageNameUseBundleIDWithUsername:(NSString *)username;

@end


@interface NSString (URL)

/**
 * 转成UTF8编码
 */
- (NSString *)toUTF8;

/**
 * URL编码 (对URL中的中文进行转码)
 * @return URL编码后的字符串
 */
- (NSString *)URLEncodedString;

/**
 * URL解码
 * @return URL解码后的字符串
 */
- (NSString *)URLDecodedString;

/**
 * 中文转换成拼音
 */
- (NSString *)pinyin;

@end


@interface NSString (Validator)

/**
 * 验证邮箱地址
 */
- (BOOL)isEmailAddress;

/**
 * 验证手机号码
 * 说明: 适用于中国内地的手机号
 */
- (BOOL)isPhoneNumber;
- (BOOL)isPhoneNumber2;

/**
 * 车牌号验证
 */
- (BOOL)isCarNumber;

/**
 * 验证车型
 */
- (BOOL)isCarType;

/**
 * 验证身份证号
 * 说明: 适用于中国内地的身份证号
 */
- (BOOL)isIdentityNumber;

/**
 * 验证密码
 * 密码规则: 数字与字母组合, 默认6-12位
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)isPassword;
- (BOOL)isPasswordWithMin:(unsigned int)min max:(unsigned int)max;

/**
 * 验证密码
 * 密码规则: 至少8位字符，且必须要包含大写字母、小写字母和数字.
 */
- (BOOL)isValidPwd;

/**
 * 验证是否为ASCII码
 */
- (BOOL)isASCIIcode;

/**
 * 验证是否为纯数字
 * 说明: 验证纯数字, 默认5位
 * 参数 size, 位数
 */
- (BOOL)isPureNumber;
- (BOOL)isPureNumberWithSize:(unsigned int)size;

/**
 * 验证昵称
 * 说明: 以中文开头, 默认4-8位
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)isNickname;
- (BOOL)isNicknameWithMin:(unsigned int)min max:(unsigned int)max;

/**
 * 验证年龄
 */
- (BOOL)isAge;

/**
 * 验证设备名称是否合法
 * 不允许包含" "和"/" (空格 和 /)
 
 @return 是否合法
 */
- (BOOL)isValidDeviceSocketName;

@end


@interface NSString (Trimmer)

/**
 * 过滤首尾的空格
 */
- (NSString *)trimWhitespace;

/**
 * 过滤首尾的空格和换行
 */
- (NSString *)trimWhitespaceAndNewline;

/**
 * 过滤所有的空格
 */
- (NSString *)trimAllWhitespace;

/**
 * 过滤所有的空格和换行
 */
- (NSString *)trimAllWhitespaceAndNewline;

/**
 * 过滤所有的 空格 和 / (使用正则表达式)
 */
- (NSString *)trimAllWhitespaceAndSlash;

@end

NS_ASSUME_NONNULL_END
