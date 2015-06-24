//
//  HomeDetailViewController.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/26.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTableViewheader];
    
}

- (void)addTableViewheader
{
    UIView *view = [UIView new];
    view.bounds = CGRectMake(0, 0, 0, 180);
    view.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
