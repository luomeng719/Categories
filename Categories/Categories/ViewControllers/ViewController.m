//
//  ViewController.m
//  Categories
//
//  Created by luomeng on 15/11/3.
//  Copyright © 2015年 luomeng. All rights reserved.
//

#import "ViewController.h"
#import "EncryManager.h"

#import "NSString+AES256.h"

#define JSON_STRING_WITH_OBJ(obj) (obj?[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:obj options:kNilOptions error:nil] encoding:NSUTF8StringEncoding]:nil)
#define JSON_OBJECT_WITH_STRING(string) (string?[NSJSONSerialization JSONObjectWithData: [string dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil]:nil)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Utils Library", nil);
    
    CGFloat value = AdaptIPad_IPhone4_5_6_6PLUS(100, 200, 300, 400, 500);
    CGFloat val = AdaptIPad_IPhone4And5_6_6Plus(100, 200, 300, 400);
    DebugLog(@"value = %f, val = %f", value, val);
    
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor cyanColor];

}

- (IBAction)startAction:(id)sender {
    NSDictionary *dic = @{
                          @"name": @"Do any additional setup after loading the view, typically from a nib.",
                          @"age": @"Do any additional setup after loading the view, typically from a nib.",
                          @"location": @"Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.",
                          @"name1": @"Do any additional setup after loading the view, typically from a nib.",
                          @"age1": @"Do any additional setup after loading the view, typically from a nib.",
                          @"location1": @"Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.Do any additional setup after loading the view, typically from a nib.",
                          @"name2": @"Do any additional setup after loading the view, typically from a nib.",
                          @"name3": @"Do any addi",
                          };
    
    dic = @{
        @"sign": @"this is a string",
        @"timeInterval": @([[NSDate date] timeIntervalSince1970]),
        @"nothing": @"hehe"
        };
    
    NSString *string = JSON_STRING_WITH_OBJ(dic);
    
    string = @"sign=thisisastring&nothing=hehe";
    NSLog(@"jsonString = %@", string);
    
    [self logExcuteTime:^{
        NSString *md52 = [[EncryManager sharedManager] md5_toMD5String:string];
        NSLog(@"MD52 = %@", md52);
        // 0.000273  0.000190
    } title:@"MD5 - 2"];
    
    [self logExcuteTime:^{
        NSString *aesEncry = [[EncryManager sharedManager] aes_encryWithAES:string];
        NSLog(@"aes Encry = %@", aesEncry);
        NSString *aesDecry = [[EncryManager sharedManager] aes_decryWithAES:aesEncry];
        NSDictionary *aesDic = JSON_OBJECT_WITH_STRING(aesDecry);
        NSLog(@"====================\nAES result = %@", aesDic);
        // 0.000593   0.000391
    } title:@"AES"];
    
    [self logExcuteTime:^{
        NSString *desEncry = [[EncryManager sharedManager] des_encryWithDES:string];
        NSString *desDecry = [[EncryManager sharedManager] des_decryWithDES:desEncry];
        NSDictionary *desDic = JSON_OBJECT_WITH_STRING(desDecry);
        NSLog(@"==================\n DES result = %@", desDic);
        // 0.000327 0.000314
    } title:@"DES"];
    
    
    NSLog(@"+++++++++++++++");
    NSString *encry = [string aes256_encrypt:@"30313233343536373839414243444546"];
    NSLog(@"-----> encry = %@", encry);
    NSString *decry = [encry aes256_decrypt:@"30313233343536373839414243444546"];
    NSLog(@"-----> decry = %@", decry);
    NSLog(@"----------------");
    
}

- (void)logExcuteTime:(void(^)())excuteBlock title:(NSString *)blockTitle {
    NSDate *startTime = [NSDate date];
    excuteBlock();
    NSDate *endTime = [NSDate date];
    NSLog(@"excuteBlock --> %@ \n time = %f", blockTitle, [endTime timeIntervalSinceDate:startTime]);
}

@end
