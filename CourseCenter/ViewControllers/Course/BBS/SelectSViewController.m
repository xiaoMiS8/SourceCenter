//
//  SelectSViewController.m
//  CourseCenter
//
//  Created by 任晓健 on 15/8/9.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "SelectSViewController.h"

@interface SelectSViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) CCHttpManager *httpManager;
@property(nonatomic, strong) NSMutableArray *forumTypes;

@end

@implementation SelectSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择板块";
    [self initManager];
    [self loadData];
}

- (void)initManager {
    self.httpManager = [CCHttpManager new];

}

- (void)loadData {
    [self.httpManager getForumTypeListwithOCID:self.OCID finished:^(EnumServerStatus status, NSObject *object) {
        self.forumTypes = [[NSMutableArray alloc] initWithArray:((ResponseObject *)object).resultArray];
        [self.tableView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.forumTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = ((ForumTypeInfo *)self.forumTypes[indexPath.row]).Title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedBlcok(self.forumTypes[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
