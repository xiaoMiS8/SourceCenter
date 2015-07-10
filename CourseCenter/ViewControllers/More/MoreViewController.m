//
//  MoreViewController.m
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreListCell.h"

@interface MoreViewController ()

@property(nonatomic, strong)NSArray *array;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = @[@[@{@"img":@"user",@"title":@"name"}],@[@{@"img":@"icon_news",@"title":@"消息中心"}],@[@{@"img":@"icon_vote",@"title":@"教学投票"},@{@"img":@"icon_download",@"title":@"离线下载"},@{@"img":@"icon_datum",@"title":@"学习资料"},@{@"img":@"icon_calendar",@"title":@"我的日程"}],@[@{@"img":@"icon_set",@"title":@"设置"}]];
    [self setCell];
    
}

- (void)setCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"MoreListCell" bundle:nil] forCellReuseIdentifier:@"MoreListCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.array.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreListCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.titleLabel.text = self.array[indexPath.section][indexPath.row][@"title"];
    [cell.imgView setImage:[UIImage imageNamed:self.array[indexPath.section][indexPath.row][@"img"]]];
    if (indexPath.section == 0 && indexPath.row == 0) {
        for (NSLayoutConstraint *constraint in cell.imgView.constraints) {
            constraint.constant = 60;
        }
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
