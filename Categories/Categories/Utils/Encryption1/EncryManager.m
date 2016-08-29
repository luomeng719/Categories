//
//  EncryManager.m
//  Encode
//
//  Created by luomeng on 16/8/29.
//  Copyright © 2016年 ILS. All rights reserved.
//

#import "EncryManager.h"
#import "MD5Util.h"
#import "AES.h"
#import "DES3Util.h"

@interface EncryManager ()
@property (nonatomic, copy) NSString *encryKey;
@end

@implementation EncryManager

+ (id)sharedManager {
    static EncryManager *__manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [[EncryManager alloc] init];
    });
    return __manager;
}

- (id)init {
    if (self = [super init]) {
        self.encryKey = @"encryKey";
    }
    return self;
}

#pragma mark - MD5
- (NSString *)md5_toMD5String:(NSString *)source {
    NSString *result = [MD5Util md5:source];
    return result;
}

#pragma mark - AES
- (NSString *)aes_encryWithAES:(NSString *)source {
    NSString *result = [AES encrypt:source password:self.encryKey];
    return result;
}
- (NSString *)aes_decryWithAES:(NSString *)encryStr {
    NSString *result = [AES decrypt:encryStr password:self.encryKey];
    return result;
}

#pragma mark - DES
- (NSString *)des_encryWithDES:(NSString *)source {
    NSString *result = [DES3Util encryptUseDES:source key:self.encryKey];
    return result;
}
- (NSString *)des_decryWithDES:(NSString *)encryStr {
    NSString *result = [DES3Util decryptUseDES:encryStr key:self.encryKey];
    return result;
}

@end
