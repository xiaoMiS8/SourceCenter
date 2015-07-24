//
//  CourseViewController.m
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "CourseViewController.h"
#import "MyCourseListCell.h"
#import "CCHttpManager.h"

@interface CourseViewController ()
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) CCHttpManager *manager;
@property(nonatomic, strong) NSMutableArray *OCList;

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initmanager];
    [self setCell];
    [self loadData];
    
  
}

- (void)initmanager {
    self.manager = [CCHttpManager new];
}

- (void)loadData {
    [self.manager getAppOCListWithIsHistroy:-1 finished:^(EnumServerStatus status, NSObject *object) {
        ResponseObject *retunObject = (ResponseObject *)object;
        self.OCList = retunObject.resultArray;
        [self.tableView reloadData];
    }];
}

- (void)setCell {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCourseListCell" bundle:nil] forCellReuseIdentifier:@"MyCourseListCell"];
}

#pragma mark- UITableViewDataSource & UITableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.OCList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCourseListCell"];
    cell.oCourse = self.OCList[indexPath.row];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCourseListCell"];
    cell.oCourse = self.OCList[indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
