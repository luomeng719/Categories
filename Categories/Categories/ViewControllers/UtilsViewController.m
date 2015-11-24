//
//  UtilsViewController.m
//  Categories
//
//  Created by luomeng on 15/11/24.
//  Copyright © 2015年 luomeng. All rights reserved.
//

#import "UtilsViewController.h"
#import "MPNVoiceManager.h"

@interface UtilsViewController ()

@end

@implementation UtilsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"about utils", @"title");
    // Do any additional setup after loading the view.
}

- (IBAction)playVibrate:(id)sender {
    [[MPNVoiceManager sharedManager] playVibrateAroundForIncommingCall];
}


@end
