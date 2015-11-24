//
//  ViewController.m
//  Categories
//
//  Created by luomeng on 15/11/3.
//  Copyright © 2015年 luomeng. All rights reserved.
//

#import "ViewController.h"

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
