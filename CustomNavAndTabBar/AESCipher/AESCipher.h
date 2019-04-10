//
//  AESCipher.h
//  AESCipher
//
//  Created by Welkin Xie on 8/13/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//
//  https://github.com/WelkinXie/AESCipher-iOS
//   由于这个库是基于 AES-128 的，因此请确保传入的 KEY 大小为 16 字节。如果要使用 AES-256 ，修改 kKeySize 为 kCCKeySizeAES256，然后提供 32 字节的 KEY 就可以了


#import <Foundation/Foundation.h>

NSString * aesEncryptString(NSString *content, NSString *key);
NSString * aesDecryptString(NSString *content, NSString *key);


NSData * aesEncryptData(NSData *data, NSData *key);
NSData * aesDecryptData(NSData *data, NSData *key);

//+ (NSData *)aesEncryptData:(NSData *)data andKey:(NSString *)key;
//+ (NSData *)aesDecryptData:(NSData *)data andKey:(NSString *)key;
