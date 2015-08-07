//
//  NewTopicViewController.m
//  CourseCenter
//
//  Created by 任晓健 on 15/8/6.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NewTopicViewController.h"
#import "NTCell1.h"
#import "NTTextViewCell.h"
#import "NTTextViewCell2.h"
@interface NewTopicViewController ()

@end

@implementation NewTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建话题";
    [self setCell];
    [self addNavItem];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

- (void)addNavItem {
    
    UIView *titleView = [[UIView alloc] init];
    titleView.bounds = CGRectMake(0, 0, 190, 50);
    self.navigationItem.titleView = titleView;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, titleView.frame.size.width, titleView.frame.size.height/2)];
    titleLabel.text = @"新建话题";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [titleView addSubview:titleLabel];
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), titleView.frame.size.width, titleView.frame.size.height/2 -10)];
    desLabel.text = @"*取一个好的标题常常能引起大家更多活跃的讨论";
    desLabel.textAlignment = NSTextAlignmentCenter;
    desLabel.textColor = [UIColor whiteColor];
    desLabel.font = [UIFont systemFontOfSize:8];
    [titleView addSubview:desLabel];
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)setCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"NTCell1" bundle:nil] forCellReuseIdentifier:@"NTCell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NTTextViewCell" bundle:nil] forCellReuseIdentifier:@"NTTextViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NTTextViewCell2" bundle:nil] forCellReuseIdentifier:@"NTTextViewCell2"];
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)done {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
       NTCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"NTCell1"];
        return cell;
    } else if (indexPath.row == 1) {
        NTTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NTTextViewCell"];
        return cell;
    } else if(indexPath.row == 2) {
        NTTextViewCell2*cell = [tableView dequeueReusableCellWithIdentifier:@"NTTextViewCell2"];
        return cell;
    }
    return nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
