//
//  EncryManager.h
//  Encode
//
//  Created by luomeng on 16/8/29.
//  Copyright © 2016年 ILS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryManager : NSObject

+ (id)sharedManager;

- (NSString *)md5_toMD5String:(NSString *)source;

- (NSString *)aes_encryWithAES:(NSString *)source;
- (NSString *)aes_decryWithAES:(NSString *)encryStr;

/**
 * DES 加密比AES 加密快 5~6倍，但是source 太长 DES 加密返回nil()
 */
- (NSString *)des_encryWithDES:(NSString *)source;
- (NSString *)des_decryWithDES:(NSString *)encryStr;
@end
