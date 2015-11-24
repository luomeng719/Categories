//
//  NetWorkViewController.m
//  Categories
//
//  Created by luomeng on 15/11/24.
//  Copyright © 2015年 luomeng. All rights reserved.
//

#import "NetWorkViewController.h"
#import "Reachability.h"

@interface NetWorkViewController ()

@end

@implementation NetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)observerNetWork {
    [[Reachability reachabilityForInternetConnection] startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityHaveChange:) name:kReachabilityChangedNotification object:nil];
}

#pragma mark - 监听网络状态变化
#pragma mark - reachabilityChanged
- (void)reachabilityHaveChange:(NSNotification *)notify {
    DebugLog(@"reachabilityHaveChange");
    Reachability* curReach = [notify object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    //得到当前网络状态
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    DebugLog(@"net work did changed state = %ld", (long)netStatus);
}

@end
