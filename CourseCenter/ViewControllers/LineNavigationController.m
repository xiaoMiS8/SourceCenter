//
//  LineNavigationController.m
//  Line0Business
//
//  Created by renxiaojian on 14/12/19.
//  Copyright (c) 2014年 line0.com. All rights reserved.
//

#import "LineNavigationController.h"

@interface LineNavigationController ()

@end

@implementation LineNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *titleTextAttribute = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.navigationBar setTitleTextAttributes:titleTextAttribute];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
