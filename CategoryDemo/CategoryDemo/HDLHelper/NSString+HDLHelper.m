//
//  NSString+HDLHelper.m
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/8.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSString+HDLHelper.h"

/**
 * NSString拓展
 * 1. 加密
 * 2. UUID等App信息
 * 3. URL编码
 * 3. 验证器
 * 4. 过滤器, 过滤空格、换行符等等
 */

@implementation NSString (HDLHelper)

@end


@implementation NSString (Encryptor)

+ (instancetype)stringFromBytes:(unsigned char *)bytes size:(int)size {
    NSMutableString *result = @"".mutableCopy;
    for (int i = 0; i < size; ++i) {
        [result appendFormat:@"%02X", bytes[i]];
    }
    return [NSString stringWithString:result];
}

/**
 * SHA1摘要算法
 
 * @return 十六进制形式的摘要字符串(大写)
 */
- (NSString *)SHA1 {
    const char *cString = self.UTF8String;
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cString, (unsigned int)strlen(cString), bytes);
    return [NSString stringFromBytes:bytes size:CC_SHA1_DIGEST_LENGTH];
}

/**
 * SHA256摘要算法
 
 * @return 十六进制形式的摘要字符串(大写)
 */
- (NSString *)SHA256 {
    const char *cString = self.UTF8String;
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(cString, (unsigned int)strlen(cString), bytes);
    return [NSString stringFromBytes:bytes size:CC_SHA256_DIGEST_LENGTH];
}

/**
 * SHA512摘要算法
 
 * @return 十六进制形式的摘要字符串(大写)
 */
- (NSString *)SHA512 {
    const char *cString = self.UTF8String;
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(cString, (unsigned int)strlen(cString), bytes);
    return [NSString stringFromBytes:bytes size:CC_SHA512_DIGEST_LENGTH];
}

/**
 * MD5信息摘要算法
 
 * @return 十六进制形式的摘要字符串(大写)
 */
- (NSString *)MD5 {
    const char *cString = self.UTF8String;
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cString, (unsigned int)strlen(cString), bytes);
    return [NSString stringFromBytes:bytes size:CC_MD5_DIGEST_LENGTH];
}

@end


@implementation NSString (Info)

/**
 获取UUID字符串
 
 每次调用都会返回一个新的唯一标示符.

 @return UUID字符串
 */
+ (NSString *)UUIDString {
    // 1. C语言风格API
    // 每次调用CFUUIDCreate，系统都会返回一个新的唯一标示符。
//    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
//    NSString *cfuuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
//    return cfuuidString;
    
    // 2. OC语言风格API
    // 跟CFUUID一样,每次调用都会获得一个新的唯一标示符。
    NSString *uuidString = [[NSUUID UUID] UUIDString];
    return uuidString;
}

/**
 * 得到Document路径
 */
+ (NSString *)documentDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return documentDirectory;
}

/**
 * 以用户名+UUID命名
 * 说明：可用于命名图片名称
 */
+ (NSString *)imageNameUseBundleIDWithUsername:(NSString *)username {
    // 图片名称格式: "UUID_username_time"
    
    // UUID
    NSString *UUID = [NSString UUIDString];
    // 得到当前操作时间
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 拼接图片名称
    NSString *headPictureName = [NSString stringWithFormat:@"%@_%@_%lld.png", UUID, username, (long long)currentTime];
    return headPictureName;
}

@end


@implementation NSString (URL)

/**
 * 转成UTF8编码
 */
- (NSString *)toUTF8 {
    NSString *utf8 = [self copy];
    // 修正扫描出来二维码里有中文时为乱码问题
    if ([self canBeConvertedToEncoding:NSShiftJISStringEncoding]) {
        utf8 = [NSString stringWithCString:[self cStringUsingEncoding:NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
        // 如果转化成utf-8失败，再尝试转化为gbk
        if (utf8 == nil) {
            utf8 = [NSString stringWithCString:[self cStringUsingEncoding:NSShiftJISStringEncoding] encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        }
    } else if ([self canBeConvertedToEncoding:NSISOLatin1StringEncoding]) {
        utf8 = [NSString stringWithCString:[self cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:NSUTF8StringEncoding];
        // 如果转化成utf-8失败，再尝试转化为gbk
        if (utf8 == nil) {
            utf8 = [NSString stringWithCString:[self cStringUsingEncoding:NSISOLatin1StringEncoding] encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
        }
    }
    return utf8;
}

/**
 * URL编码 (对URL中的中文进行转码)
 * @return URL编码后的字符串
 */
- (NSString *)URLEncodedString {
    NSString *charactersToEscape = @"!*'();:@&=+$,/?%#[] ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedURL = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedURL;
}

/**
 * URL解码
 * @return URL解码后的字符串
 */
- (NSString *)URLDecodedString {
    NSString *encodedURL = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, CFSTR("")));
    return encodedURL;
}

/**
 * 中文转换成拼音
 */
- (NSString *)pinyin {
    NSMutableString *mutable = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutable, NULL, kCFStringTransformToLatin, false);
    mutable = (NSMutableString *)[mutable stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return [mutable stringByReplacingOccurrencesOfString:@"'" withString:@""];
}

@end


#pragma mark - 验证

@implementation NSString (Validator)

/**
 * 验证邮箱地址
 */
- (BOOL)isEmailAddress {
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *assert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [assert evaluateWithObject:self];
}

/**
 * 验证手机号码
 * 说明: 适用于中国内地的手机号
 */
- (BOOL)isPhoneNumber {
    /**
          * 手机号码
          * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
          * 联通：130,131,132,152,155,156,185,186
          * 电信：133,1349,153,180,189
          */
    NSString *mobileRegex = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
          * 中国移动：China Mobile
          * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
          */
    NSString *cmobileRegex = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
          * 中国联通：China Unicom
          * 130,131,132,152,155,156,185,186
          */
    NSString *cunicomRegex = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    /**
          * 中国电信：China Telecom
          * 133,1349,153,180,189
          */
    NSString *ctelecomRegex = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    /**
          * 大陆地区固话及小灵通
          * 区号：010,020,021,022,023,024,025,027,028,029
          * 号码：七位或八位
          */
    NSString *chandRegex = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *mobileAssert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    NSPredicate *cmobileAssert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cmobileRegex];
    NSPredicate *cunicomAssert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cunicomRegex];
    NSPredicate *ctelecomAssert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ctelecomRegex];
    NSPredicate *chandAssert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chandRegex];
    
    return ([mobileAssert evaluateWithObject:self] ||
            [chandAssert evaluateWithObject:self] ||
            [cmobileAssert evaluateWithObject:self] ||
            [cunicomAssert evaluateWithObject:self] ||
            [ctelecomAssert evaluateWithObject:self]
            );
}

- (BOOL)isPhoneNumber2 {
    // 手机号以13,15,18开头，八个数字字符
    NSString *regex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *assert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [assert evaluateWithObject:self];
}

/**
 * 车牌号验证
 */
- (BOOL)isCarNumber {
    NSString *regex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *assert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [assert evaluateWithObject:self];
}

/**
 * 验证车型
 */
- (BOOL)isCarType {
    NSString *regex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *assert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [assert evaluateWithObject:self];
}

/**
 * 验证身份证号
 * 说明: 适用于中国内地的身份证号
 */
- (BOOL)isIdentityNumber {
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *assert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [assert evaluateWithObject:self];
}

/**
 * 验证密码
 * 密码规则: 数字与字母组合, 默认6-12位
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)isPassword {
    NSString *regex = @"^[a-zA-Z0-9]{6,12}+$";
    NSPredicate *assert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [assert evaluateWithObject:self];
}

- (BOOL)isPasswordWithMin:(unsigned int)min max:(unsigned int)max {
    NSString *regex = [NSString stringWithFormat:@"^[a-zA-Z0-9]{%u,%u}+$", min, max];
    NSPredicate *assert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [assert evaluateWithObject:self];
}

/**
 * 验证密码
 * 密码规则: 至少8位字符，且必须要包含大写字母、小写字母和数字.
 */
- (BOOL)isValidPwd {
//    if (self.length < 8) {
//        return NO;
//    }
//
//    BOOL isLower = NO, isUpper = NO, isNum = NO;
//    for (int k = 0; k < self.length; k++) {
//        char tmp = [self characterAtIndex:k];
//        if (tmp <= 'z' && tmp >= 'a') {
//            isLower = YES;
//        } else if (tmp <= 'Z' && tmp >= 'A') {
//            isUpper = YES;
//        } else if (tmp <= '9' && tmp >= '0') {
//            isNum = YES;
//        }
//    }
//
//    return isLower && isUpper && isNum;
    
    NSString *regex = @"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$";
    NSPredicate *assert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [assert evaluateWithObject:self];
}

/**
 * 验证是否为ASCII码
 */
- (BOOL)isASCIIcode {
    NSInteger len = self.length;
    NSInteger dateLen = [[self dataUsingEncoding:NSUTF8StringEncoding] length];
    return (len == dateLen);
}

/**
 * 验证是否为纯数字
 * 说明: 验证纯数字, 默认5位
 * 参数 size, 位数
 */
- (BOOL)isPureNumber {
    NSString *regex = @"^[0-9]{5}$";
    NSPredicate *assert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [assert evaluateWithObject:self];
}

- (BOOL)isPureNumberWithSize:(unsigned int)size {
    NSString *regex = [NSString stringWithFormat:@"^[0-9]{%d}$", size];
    NSPredicate *assert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [assert evaluateWithObject:self];
}

/**
 * 验证昵称
 * 说明: 以中文开头, 默认4-8位
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)isNickname {
    NSString *regex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *assert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [assert evaluateWithObject:self];
}

- (BOOL)isNicknameWithMin:(unsigned int)min max:(unsigned int)max {
    NSString *regex = [NSString stringWithFormat:@"^[\u4e00-\u9fa5]{%u,%u}$", min, max];
    NSPredicate *assert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [assert evaluateWithObject:self];
}

/**
 * 验证年龄
 */
- (BOOL)isAge {
    NSString *regex = @"([1-9]|[1-9][0-9]|1[0-4][0-9])";
    NSPredicate *assert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [assert evaluateWithObject:self];
}

/**
 * 验证设备名称是否合法
 * 不允许包含" "和"/" (空格 和 /)
 
 @return 是否合法
 */
- (BOOL)isValidDeviceSocketName {
    NSString *regex = [NSString stringWithFormat:@"[^ /]+"];
    NSPredicate *assert = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [assert evaluateWithObject:self];
}

@end


#pragma mark - 过滤

@implementation NSString (Trimmer)

/**
 * 过滤首尾的空格
 */
- (NSString *)trimWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/**
 * 过滤首尾的空格和换行
 */
- (NSString *)trimWhitespaceAndNewline {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 * 过滤所有的空格
 */
- (NSString *)trimAllWhitespace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

/**
 * 过滤所有的空格和换行
 */
- (NSString *)trimAllWhitespaceAndNewline {
    NSString *result = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    result = [result stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    return result;
}

/**
 * 过滤所有的 空格 和 / (使用正则表达式)
 */
- (NSString *)trimAllWhitespaceAndSlash {
    NSString *newString = self;
    
    // 正则表达式的模式字符串
    NSString *regString = @"[/ ]";
    NSError *error = nil;
    // 创建正则表达式对象
    NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:regString options:NSRegularExpressionCaseInsensitive error:&error];
    if (!error) {
        newString = [reg stringByReplacingMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length) withTemplate:@""];
    }
    return newString;
}

@end

