//
//  BaseViewController.m
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCustomBackWithImage:@"barbuttonItem_back" title:@""];
    
}

/**
 *	@brief	设置视图控制器的backBarButtonItem
 *
 *	@param 	imagename 	图片
 *	@param 	title 	标题
 */
- (void)setupCustomBackWithImage:(NSString *)imagename title:(NSString *)title

{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    [backItem setBackButtonBackgroundImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    backItem.title = title;
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
