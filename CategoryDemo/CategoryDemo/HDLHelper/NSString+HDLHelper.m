//
//  NSString+HDLHelper.m
//  CategoryDemo
//
//  Created by hadlinks on 2019/7/8.
//  Copyright © 2019 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSString+HDLHelper.h"
#import "NSData+HDLHelper.h"

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

/// 对字符串进行Base64编码
- (NSString *)base64Encode {
    if (self.length == 0) {
        return @"";
    }
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

/// 对Base64编码字符串进行解码
- (NSString *)base64Decode {
    if (self.length == 0) {
        return @"";
    }
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
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

/// 加密
/// @param key 密钥
/// @param enable 加密前是否对字符串进行Base64编码
- (NSString *)AES256EncryptWithKey:(NSString *)key enableBase64Encode:(BOOL)enable {
    NSString *sourceStr = self;
    if (enable) {
        sourceStr = [self base64Encode];
    }
    // 1. 字符串转换为二进制数据
    const char *cstr = [sourceStr cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:sourceStr.length];
    
    // 2. 对二进制数据进行加密
    NSData *result = [data AES256EncryptWithKey:key];
    
    // 3. 加密结果转换为二进制字符串
    if (result && result.length > 0) {
        Byte *datas = (Byte *)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        for(int i = 0; i < result.length; i++) {
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    return nil;
}

/// 解密
/// @param key 密钥
/// @param enable 解密完成后是否对结果进行Base64解码
- (NSString *)AES256DecryptWithKey:(NSString *)key enableBase64Encode:(BOOL)enable {
    // 1. 二进制字符串转换为二进制数据
    NSMutableData *data = [NSMutableData dataWithCapacity:self.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0', '\0', '\0'};
    for (int i = 0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i * 2];
        byte_chars[1] = [self characterAtIndex:i * 2 + 1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    
    // 2. 对二进制数据进行解密
    NSData *result = [data AES256DecryptWithKey:key];
    
    // 3. 二进制数据转换为字符串
    if (result && result.length > 0) {
        NSString *resultStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        if (enable) {
            resultStr = [resultStr base64Decode];
        }
        return resultStr;
    }
    return nil;
}

/// 加密
/// @param key 密钥
- (NSString *)AES256EncryptWithKey:(NSString *)key {
    // 针对对中文加密失败的情况,需要先将字符串转换为base64字符串,然后再进行加密
    return [self AES256EncryptWithKey:key enableBase64Encode:YES];
}

/// 解密
/// @param key 密钥
- (NSString *)AES256DecryptWithKey:(NSString *)key {
    // 针对对中文加密失败的情况,解密完成后需要对字符串进行base64解码操作
    return [self AES256DecryptWithKey:key enableBase64Encode:YES];
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
 * 以 用户名 + UUID 命名
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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/**
 * 验证手机号码
 * 说明: 适用于中国内地的手机号
 */
- (BOOL)isPhoneNumber {
    /**
     * 手机号码号段分配情况:
     *
     * 移动：134~139,144(物联网),147,148(物联网),150~152,157~159,165,1703,1705,1706,172(物联网),178,182~184,
     *      187,188,195,197,198,1440
     *
     * 联通：130,131,132,140(物联网),145,146(物联网),155,156,166,167,175,176,185,186,196,1704,
     *      1707~1719
     *
     * 电信：133,141(物联网),149(物联网),153,162,1700~1702,173,1740,177,180,181,189,190~193,199,1349
     *
     * 广电：192,
     *
     */
    
    /**
     * 中国移动：China Mobile
     */
    NSArray *cmobileNums = @[
        @"134", @"135", @"136", @"137", @"138", @"139",
        @"144", @"1440", @"147", @"148",
        @"150", @"151", @"152", @"157", @"158", @"159",
        @"165",
        @"1703", @"1705", @"1706", @"172", @"178",
        @"182", @"183", @"184", @"187", @"188",
        @"195", @"197", @"198"
    ];
    
    /**
     * 中国联通：China Unicom
     */
    NSArray *cunicomNums = @[
        @"130", @"131", @"132",
        @"140", @"145", @"146",
        @"155", @"156",
        @"166", @"167",
        @"1704", @"1707", @"1708", @"1709", @"1710", @"1711", @"1712", @"1713", @"1714",
        @"1715", @"1716", @"1717", @"1718", @"1719", @"175", @"176",
        @"185", @"186",
        @"196"
    ];
    
    /**
     * 中国电信：China Telecom
     */
    NSArray *ctelecomNums = @[
        @"133", @"1349",
        @"141", @"149",
        @"153",
        @"162",
        @"1700", @"1701", @"1702", @"173", @"1740", @"177",
        @"180", @"181", @"189",
        @"190", @"191", @"193", @"199"
    ];
    
    /**
     * 中国广电：China Broadcast Network
     */
    NSArray *cbnNums = @[
        @"192"
    ];
    
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    NSArray *chandNums = @[
        @"010", @"020", @"021", @"022", @"023", @"024", @"025", @"027", @"028", @"029"
    ];
    
    
    // 正则表达式示例: ^(134|135|136)\\d{8}$
    // 正则表达式示例: ^(1703|1705|1706)\\d{7}$
    NSString *regex1 = @"^(";
    NSString *regex2 = @"^(";
    NSMutableArray *nums = [NSMutableArray array];
    [nums addObjectsFromArray:cmobileNums];
    [nums addObjectsFromArray:cunicomNums];
    [nums addObjectsFromArray:ctelecomNums];
    [nums addObjectsFromArray:cbnNums];
    [nums addObjectsFromArray:chandNums];
    for (NSString *num in nums) {
        if ([num isEqualToString:nums.lastObject]) {
            if (num.length == 3) {
                regex1 = [regex1 stringByAppendingString:num];
            } else if (num.length == 4) {
                regex2 = [regex2 stringByAppendingString:num];
            }
        } else {
            if (num.length == 3) {
                regex1 = [regex1 stringByAppendingFormat:@"%@|", num];
            } else if (num.length == 4) {
                regex2 = [regex2 stringByAppendingFormat:@"%@|", num];
            }
        }
    }
    regex1 = [regex1 stringByAppendingFormat:@")\\d{8}$"];
    regex2 = [regex2 stringByAppendingFormat:@")\\d{7}$"];

    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex1];
    NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    return ([predicate1 evaluateWithObject:self] || [predicate2 evaluateWithObject:self]);
}

/**
 * 车牌号验证
 */
- (BOOL)isCarNumber {
    NSString *regex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/**
 * 验证车型
 */
- (BOOL)isCarType {
    NSString *regex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/**
 * 验证身份证号
 * 说明: 适用于中国内地的身份证号
 */
- (BOOL)isIdentityNumber {
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/**
 * 验证密码
 * 密码规则: 数字与字母组合, 默认6-12位
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)isPassword {
    NSString *regex = @"^[a-zA-Z0-9]{6,12}+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isPasswordWithMin:(unsigned int)min max:(unsigned int)max {
    NSString *regex = [NSString stringWithFormat:@"^[a-zA-Z0-9]{%u,%u}+$", min, max];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/**
 * 验证密码
 * 密码规则: 至少8位字符，且必须要包含大写字母、小写字母和数字.
 */
- (BOOL)isValidPwd {
    NSString *regex = @"^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{8,}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isPureNumberWithSize:(unsigned int)size {
    NSString *regex = [NSString stringWithFormat:@"^[0-9]{%d}$", size];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/**
 * 验证昵称
 * 说明: 以中文开头, 默认4-8位
 * 参数 min, 最少位
 * 参数 max, 最大位
 */
- (BOOL)isNickname {
    NSString *regex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isNicknameWithMin:(unsigned int)min max:(unsigned int)max {
    NSString *regex = [NSString stringWithFormat:@"^[\u4e00-\u9fa5]{%u,%u}$", min, max];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/**
 * 验证年龄 (范围: 1岁 ~ 149岁)
 */
- (BOOL)isAge {
    NSString *regex = @"([1-9]|[1-9][0-9]|1[0-4][0-9])";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

/**
 * 验证设备名称是否合法
 * 不允许包含" "和"/" (空格 和 /)
 
 @return 是否合法
 */
- (BOOL)isValidDeviceSocketName {
    NSString *regex = [NSString stringWithFormat:@"[^ /]+"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
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

