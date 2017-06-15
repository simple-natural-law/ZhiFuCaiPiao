//
//  NSData+extend.m
//  gongwuche_ios_driver
//
//  Created by 讯心科技 on 2017/5/2.
//  Copyright © 2017年 讯心科技. All rights reserved.
//

#import "NSData+extend.h"
#import <CommonCrypto/CommonCryptor.h>

// 设置编码
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";


@implementation NSData (extend)


/**
 DES加密解密
 
 @param text 需要加密／解密的内容
 @param encryptOperation 加密／解密
 @param key 密钥
 @return 加密／解密后的内容
 */
static const char* encryptWithKeyAndType(const char*text,CCOperation encryptOperation,char *key)
{
    NSString *string = [[NSString alloc] initWithCString:text encoding:NSUTF8StringEncoding];
    const void *dataIn;
    size_t dataInLength;
    
    if (encryptOperation == kCCDecrypt) //解密
    {
        NSData *decryptData = [string dataUsingEncoding:NSUTF8StringEncoding];
        dataInLength = [decryptData length];
        dataIn = [decryptData bytes];
    }else
    {
        NSData *encryptData = [string dataUsingEncoding:NSUTF8StringEncoding];
        dataInLength = [encryptData length];
        dataIn = (const void *)[encryptData bytes];
    }
    
    uint8_t *dataOut = NULL;
    size_t dataOutAvailabel = 0;
    size_t dataOutMoved = 0;
    
    dataOutAvailabel = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc(dataOutAvailabel*sizeof(uint8_t));
    memset((void *)dataOut, 00, dataOutAvailabel);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    const void *vKey = key;
    const void *iv = key;
    
    CCCrypt(encryptOperation, kCCAlgorithmDES, kCCOptionPKCS7Padding, vKey, kCCKeySizeDES, iv, dataIn, dataInLength, (void *)dataOut, dataOutAvailabel, &dataOutMoved);
    
    NSString *result = nil;
    
    if (encryptOperation == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void*)dataOut length:(NSUInteger)dataOutMoved] encoding:NSUTF8StringEncoding];
    }else
    {
        
        NSData *data = [NSData dataWithBytes:(const void*)dataOut length:(NSUInteger)dataOutMoved];
        
        result = [data charToString];
    }
    
    return [result UTF8String];
}



+ (NSString *)encryptUseDESForPlainText:(NSString *)plainText key:(NSString *)key
{
    const char *contentChar = [plainText UTF8String];
    char *keyChar = (char*)[key UTF8String];
    const char *miChar;
    
    miChar = encryptWithKeyAndType(contentChar, kCCEncrypt, keyChar);
    
    return [NSString stringWithCString:miChar encoding:NSUTF8StringEncoding];
}


+ (NSString *)decryptUseDESForCipherText:(NSString *)cipherText key:(NSString *)key
{
    const char *contentChar = [cipherText UTF8String];
    char *keyChar = (char*)[key UTF8String];
    const char *miChar;
    
    miChar = encryptWithKeyAndType(contentChar, kCCDecrypt, keyChar);
    
    return [NSString stringWithCString:miChar encoding:NSUTF8StringEncoding];
}


//把字节数组转为16进制字符串
-(NSString*)charToString
{
    unsigned char * c = (unsigned char *)[self bytes];
    NSMutableString * string = [[NSMutableString alloc]initWithCapacity:0];
    for (int k=0; k<self.length; k++) {
        int n = c[k];
        int i = n/16;
        int j = n%16;
        if (j<10) {
            if (i<10) {
                NSString * str = [[NSString alloc]initWithFormat:@"%d%d",i,j];
                [string appendString:str];
            }
            else{
                NSString * str = [[NSString alloc]initWithFormat:@"%c%d",('A'+(i-10)),j];
                [string appendString:str];
            }
        }
        else{
            if (i<10) {
                NSString * str = [[NSString alloc]initWithFormat:@"%d%c",i,('A'+(j-10))];
                [string appendString:str];
            }
            else{
                NSString * str = [[NSString alloc]initWithFormat:@"%c%c",('A'+(i-10)),('A'+(j-10))];
                [string appendString:str];
            }
        }
    }
    return [NSString stringWithString:string];
}

//把16进制字符串转换为字节数组
-(NSData*)StringTochar
{
    char * c = (char*)[self bytes];
    char newC[self.length/2];
    for (int i=0; i<self.length/2; i++) {
        int l = c[2*i];
        int r = c[2*i+1];
        if (l>='0' && l<='9') {
            l=(l-'0')*16;
        }
        else if(l>='A' && l<='F'){
            l=((l-'A')+10)*16;
        }
        if (r>='0' && r<='9') {
            r=r-'0';
        }
        else if(r>='A' && r<='F'){
            r=(r-'A')+10;
        }
        newC[i] = l+r ;
    }
    
    NSData * resultData = [NSData dataWithBytes:newC length:self.length/2];
    return resultData;
}



+ (NSData *)dataWithBase64EncodedString:(NSString *)string {
    
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:@""];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    free(bytes);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}


- (NSString *)base64Encoding;
{//调用base64的方法
    
    if ([self length] == 0)
        return @"";
    
    char *characters = malloc((([self length] + 2) / 3) * 4);
    
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [self length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [self length])
            buffer[bufferLength++] = ((char *)[self bytes])[i++];
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}


@end
