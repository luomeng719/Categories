//
//  ViewController.m
//  Categories
//
//  Created by luomeng on 15/11/3.
//  Copyright © 2015年 luomeng. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+TintColor.h"
#import "UIView+CustomBorder.h"
#import "UIView+AutoLayout.h"
#import "DXAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat value = AdaptIPad_IPhone4_5_6_6PLUS(100, 200, 300, 400, 500);
    CGFloat val = AdaptIPad_IPhone4And5_6_6Plus(100, 200, 300, 400);
    DebugLog(@"value = %f, val = %f", value, val);
    
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIImage *image = [[UIImage imageNamed:@"image"] imageWithGradientTintColor:[UIColor purpleColor]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    
    [imageView addBottomBorderWithColor:[UIColor whiteColor] width:10 excludePoint:10 edgeType:ExcludeAllPoint];
    [imageView addTopBorderWithColor:[UIColor orangeColor] width:10 excludePoint:10 edgeType:ExcludeAllPoint];
    [imageView addLeftBorderWithColor:[UIColor grayColor] width:10 excludePoint:10 edgeType:ExcludeAllPoint];
    [imageView addRightBorderWithColor:[UIColor redColor] width:10 excludePoint:10 edgeType:ExcludeAllPoint];
    
    
//    UIView *view1 = [UIView autoLayoutView];
//    view1.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:view1];
//    [view1 pinToSuperviewEdges:JRTViewPinAllEdges inset:10];
//    
//    [view1 addBottomBorderWithColor:[UIColor whiteColor] width:10 excludePoint:30 edgeType:ExcludeAllPoint];
//    [view1 addTopBorderWithColor:[UIColor orangeColor] width:10 excludePoint:30 edgeType:ExcludeAllPoint];
//    [view1 addLeftBorderWithColor:[UIColor grayColor] width:10 excludePoint:30 edgeType:ExcludeAllPoint];
//    [view1 addRightBorderWithColor:[UIColor redColor] width:10 excludePoint:30 edgeType:ExcludeAllPoint];
}
- (IBAction)buttonAction:(id)sender {
    DXAlertView *alertView = [[DXAlertView alloc] initWithTitle:@"title" contentText:@"dxalertView" leftButtonTitle:@"left" rightButtonTitle:@"right"];
    [alertView show];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
