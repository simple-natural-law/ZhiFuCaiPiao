//
//  NSData+extend.h
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (extend)

/**
 * 对字符串进行DES加密
 * @param  plainText 需要加密的字符串
 * @return 加密好的字符串
 */
+ (NSString *)encryptUseDESForPlainText:(NSString *)plainText key:(NSString *)key;


/**
 DES解密
 
 @param cipherText DES加密的字符串
 @return 解密好的字符串
 */
+ (NSString *)decryptUseDESForCipherText:(NSString *)cipherText key:(NSString *)key;


/**
 *  Base64字符串解码, “=”字符是可选的填充。空白符被忽略。
 *
 *  @param string 需要解码的Base64字符串
 *
 *  @return 返回已经解码的数据，失败返回nil
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;


/**
 *  将数据流编码为Base64字符串
 *
 *  @return 返回Base64字符串，失败返回nil
 */
- (NSString *)base64Encoding;


@end
