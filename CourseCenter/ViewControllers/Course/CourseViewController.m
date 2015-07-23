//
//  CourseViewController.m
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "CourseViewController.h"
#import "MyCourseListCell.h"

@interface CourseViewController ()
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCell];
}

- (void)setCell {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCourseListCell" bundle:nil] forCellReuseIdentifier:@"MyCourseListCell"];
}

#pragma mark- UITableViewDataSource & UITableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCourseListCell"];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCourseListCell"];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
