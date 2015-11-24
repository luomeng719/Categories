//
//  UITestViewController.m
//  Categories
//
//  Created by luomeng on 15/11/24.
//  Copyright © 2015年 luomeng. All rights reserved.
//

#import "UITestViewController.h"
#import "DXAlertView.h"
#import "UIImage+TintColor.h"
#import "UIView+CustomBorder.h"
#import "UIView+AutoLayout.h"

@interface UITestViewController ()

@end

@implementation UITestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"about UI", @"title");
    // Do any additional setup after loading the view.
    
    UIImage *image = [[UIImage imageNamed:@"image"] imageWithGradientTintColor:[UIColor purpleColor]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    
    [imageView addBottomBorderWithColor:[UIColor whiteColor] width:10 excludePoint:10 edgeType:ExcludeAllPoint];
    [imageView addTopBorderWithColor:[UIColor orangeColor] width:10 excludePoint:10 edgeType:ExcludeAllPoint];
    [imageView addLeftBorderWithColor:[UIColor grayColor] width:10 excludePoint:10 edgeType:ExcludeAllPoint];
    [imageView addRightBorderWithColor:[UIColor redColor] width:10 excludePoint:10 edgeType:ExcludeAllPoint];
}

- (IBAction)dropAlertView:(id)sender {
    DXAlertView *alertView = [[DXAlertView alloc] initWithTitle:@"title" contentText:@"dxalertView" leftButtonTitle:@"left" rightButtonTitle:@"right"];
    [alertView show];
}


@end
