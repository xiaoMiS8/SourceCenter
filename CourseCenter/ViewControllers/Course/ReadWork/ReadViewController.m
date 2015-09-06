//
//  ReadViewController.m
//  CourseCenter
//
//  Created by 任晓健 on 15/8/10.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "ReadViewController.h"
#import "ReadListCell.h"
@interface ReadViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReadListCell" bundle:nil] forCellReuseIdentifier:@"ReadListCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReadListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReadListCell"];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReadListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReadListCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
