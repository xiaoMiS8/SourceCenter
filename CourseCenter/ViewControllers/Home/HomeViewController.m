//
//  HomeViewController.m
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "HomeViewController.h"
#import "NextViewController.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)setSearchBtn:(UIButton *)searchBtn
{
    _searchBtn = searchBtn;
    [self addbSearchBtnAction];
}

- (void)addbSearchBtnAction
{
    [self.searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
}

- (void)search
{
    
}


- (IBAction)btnAction:(id)sender {
    NextViewController *nextVC = [NextViewController new];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    [app.nav pushViewController:nextVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
