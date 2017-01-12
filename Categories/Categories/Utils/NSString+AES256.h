//
//  NSString+AES256.h
//  Categories
//
//  Created by luomeng on 16/12/30.
//  Copyright © 2016年 luomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES256)
-(NSString *) aes256_encrypt:(NSString*)key;// 加密
-(NSString *) aes256_decrypt:(NSString *)key;// 解密
@end
