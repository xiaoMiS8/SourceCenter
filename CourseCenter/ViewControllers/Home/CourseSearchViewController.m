//
//  CourseSearchViewController.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/26.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "CourseSearchViewController.h"

@interface CourseSearchViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CourseSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课程搜索";
    [self addTableviewHeader];
}

- (void)addTableviewHeader
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    searchBar.placeholder = @"这里可以搜索您感兴趣的视频课程哦！";
    self.tableView.tableHeaderView = searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
