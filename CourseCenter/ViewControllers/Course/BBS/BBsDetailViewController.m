//
//  BBsDetailViewController.m
//  CourseCenter
//
//  Created by jian on 15/8/3.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "BBsDetailViewController.h"
#import "BBsDetailCell.h"
#import "BBSResponeCell.h"
@interface BBsDetailViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bomView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property(nonatomic, strong) CCHttpManager *manager;

@property(nonatomic, strong) NSArray *respones;

@end

@implementation BBsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帖子正文";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setBomView];
    [self setCell];
    [self initManager];
    [self loadData];
    
}

- (void)setBomView {
    self.textView.layer.cornerRadius = 3;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderColor = [UIColor blackColor].CGColor;
    self.textView.layer.borderWidth = 0.5f;
}

- (void)initManager {
    self.manager = [CCHttpManager new];
}

- (void)loadData {
    [self.manager getAppForumResponseInfoListWithTopicID:self.topic.TopicID finished:^(EnumServerStatus status, NSObject *object) {
        self.respones = ((ResponseObject *)object).resultArray;
        [self.tableView reloadData];
    }];
}

- (void)setCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"BBsDetailCell" bundle:nil] forCellReuseIdentifier:@"BBsDetailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BBSResponeCell" bundle:nil] forCellReuseIdentifier:@"BBSResponeCell"];
}

- (CGFloat)tableView:( UITableView *)tableView heightForRowAtIndexPath:( NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BBsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBsDetailCell"];
        cell.topic = self.topic;
        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height + 1;
    }
    else {
        BBSResponeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBSResponeCell"];
        cell.response = self.respones[indexPath.row - 1];
        CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height + 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:( UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:( UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.respones.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BBsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBsDetailCell"];
        cell.topic = self.topic;
        return cell;
    }
    else {
        BBSResponeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBSResponeCell"];
        cell.response = self.respones[indexPath.row - 1];
        return cell;
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.textView.text = @"";
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
