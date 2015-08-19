//
//  SelectClassViewController.m
//  CourseCenter
//
//  Created by 任晓健 on 15/8/19.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "SelectClassViewController.h"
#import "NewNotiSelectCell.h"
@interface SelectClassViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSArray *classes;

@end

@implementation SelectClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择班级";
    [self setCell];
    [self loadData];
    
}

- (void)loadData {
    CCHttpManager *http = [CCHttpManager new];
    [http getOCClassDropdownListWithOCID:self.OCID finished:^(EnumServerStatus status, NSObject *object) {
        self.classes = ((ResponseObject *)object).resultArray;
        [self.tableView reloadData];
    }];
}

- (void)setCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"NewNotiSelectCell" bundle:nil] forCellReuseIdentifier:@"NewNotiSelectCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.classes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewNotiSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewNotiSelectCell"];
    cell.nameLabel.text = ((OCClassInfo *)self.classes[indexPath.row]).TeachingClassName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedBlcok(self.classes[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
