//
//  CourseBaseViewController.m
//  CourseCenter
//
//  Created by jian on 15/7/25.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "CourseBaseViewController.h"

@interface CourseBaseViewController ()

@end

@implementation CourseBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void) pushViewController:(UIViewController *)viewController {
    self.PushBlock(viewController);
}


@end
