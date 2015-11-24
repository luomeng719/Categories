//
//  UITestViewController.m
//  Categories
//
//  Created by luomeng on 15/11/24.
//  Copyright © 2015年 luomeng. All rights reserved.
//

#import "UITestViewController.h"
#import "DXAlertView.h"

@interface UITestViewController ()

@end

@implementation UITestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"about UI", @"title");
    // Do any additional setup after loading the view.
}

- (IBAction)dropAlertView:(id)sender {
    DXAlertView *alertView = [[DXAlertView alloc] initWithTitle:@"title" contentText:@"dxalertView" leftButtonTitle:@"left" rightButtonTitle:@"right"];
    [alertView show];
}


@end
