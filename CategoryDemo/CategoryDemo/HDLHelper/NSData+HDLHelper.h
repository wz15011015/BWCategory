//
//  NSData+HDLHelper.h
//  CategoryDemo
//
//  Created by hadlinks on 2020/3/23.
//  Copyright © 2020 Ningbo Hadlinks IOT Science&Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (HDLHelper)

@end




/// AES加密与解密 (对称加密算法)
@interface NSData (HDLAES)

/// 加密
/// @param key 密钥
- (NSData *)AES256EncryptWithKey:(NSString *)key;

/// 解密
/// @param key 密钥
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
