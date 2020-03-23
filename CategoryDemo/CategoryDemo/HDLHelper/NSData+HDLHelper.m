//
//  NSData+HDLHelper.m
//  CategoryDemo
//
//  Created by hadlinks on 2020/3/23.
//  Copyright © 2020 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+HDLHelper.h"

@implementation NSData (HDLHelper)

@end




/// AES加密与解密 (对称加密算法)
///
/// AES,高级加密标准（英语：Advanced Encryption Standard，缩写：AES），在密码学中又称Rijndael加密法，
/// 是美国联邦政府采用的一种区块加密标准。这个标准用来替代原先的DES，已经被多方分析且广为全世界所使用。
///
/// 严格地说，AES和Rijndael加密法并不完全一样（虽然在实际应用中二者可以互换），
/// 因为Rijndael加密法可以支持更大范围的区块和密钥长度：AES的区块长度固定为128 比特，密钥长度则可以是128，192或256比特；
/// 而Rijndael使用的密钥和区块长度可以是32位的整数倍，以128位为下限，256比特为上限。
///
/// AES最常见的有3种方案，分别是AES-128、AES-192和AES-256，它们的区别在于密钥长度不同，
/// AES-128的密钥长度为16bytes（128bit / 8），后两者分别为24bytes和32bytes。密钥越长，安全强度越高，
/// 但伴随运算轮数的增加，带来的运算开销就会更大，所以用户应根据不同应用场合进行合理选择。
/// 用户在应用过程中，除了关注密钥长度外，还应注意确认算法模式。
/// AES算法有五种加密模式，即CBC、ECB、CTR、OCF、CFB，后三种模式因其较为复杂且应用较少。

@implementation NSData (HDLAES)

/// 加密
/// @param key 密钥
- (NSData *)AES256EncryptWithKey:(NSString *)key {
    // AES的数据块长度固定为128 bit，密钥长度则可以是128、192或256 bit
    
    char keyPtr[kCCKeySizeAES256 + 1]; // 密钥长度
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128; // 数据块长度,目前只支持128位的数据块
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    
    return nil;
}

/// 解密
/// @param key 密钥
- (NSData *)AES256DecryptWithKey:(NSString *)key {
    // AES的数据块长度固定为128 bit，密钥长度则可以是128、192或256 bit
    
    char keyPtr[kCCKeySizeAES256 + 1]; // 密钥长度
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128; // 数据块长度,目前只支持128位的数据块
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    
    return nil;
}

@end
