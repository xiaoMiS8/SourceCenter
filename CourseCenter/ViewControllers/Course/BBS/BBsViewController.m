//
//  BBsViewController.m
//  CourseCenter
//
//  Created by jian on 15/7/25.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "BBsViewController.h"
#import "BBSListCell.h"
#import "MJRefresh.h"
#import "BBsDetailViewController.h"
#import "NewTopicViewController.h"
#import "LineNavigationController.h"
@interface BBsViewController ()

@property(nonatomic, strong) CCHttpManager *manager;
@property(nonatomic, strong) NSMutableArray *topics;
@property (weak, nonatomic) IBOutlet UILabel *blueLabel;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property(nonatomic, assign) int index;

@end

@implementation BBsViewController

- (void)setRightBtn1:(UIButton *)rightBtn1 {
    _rightBtn1 = rightBtn1;
}

- (void)setRightBtn2:(UIButton *)rightBtn2 {
    _rightBtn2 = rightBtn2;
    [rightBtn2 removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [rightBtn2 setImage:[UIImage imageNamed:@"notification_add"] forState:UIControlStateNormal];
    [rightBtn2 addTarget:self action:@selector(rightBtn2Action:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)rightBtn1Action:(UIButton *)btn {
    
}

- (void)rightBtn2Action:(id)sender {
    NewTopicViewController *newtopicVC = [NewTopicViewController new];
    LineNavigationController *nav = [[LineNavigationController alloc] initWithRootViewController:newtopicVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 1;
    [self setCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initManager];
    [self addheader];
}

- (void)addheader {
    __weak typeof(self) wself = self;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [wself loadData];
    }];
    [self.tableView.header beginRefreshing];
}

- (void)addfooter {
     __weak typeof(self) wself = self;
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [wself loadMore];
    }];
}

- (void)initManager {
    self.manager = [CCHttpManager new];
}

- (void)loadData {
    self.index = 1;
    [self.manager getAppForumTopicListWithOCID:161 ForumTypeID:1 IsEssence:NO IsMyStart:NO IsMyJoin:NO SearchKey:nil PageIndex:self.index PageSize:10 finished:^(EnumServerStatus status, NSObject *object) {
        self.topics = [[NSMutableArray alloc] initWithArray:((ResponseObject *)object).resultArray];
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        if (self.topics.count > 0) {
            [self addfooter];
        }
    }];
}

- (void)loadMore {
    self.index ++;
    [self.manager getAppForumTopicListWithOCID:161 ForumTypeID:1 IsEssence:NO IsMyStart:NO IsMyJoin:NO SearchKey:nil PageIndex:self.index PageSize:10 finished:^(EnumServerStatus status, NSObject *object) {
        [self.topics addObjectsFromArray:((ResponseObject *)object).resultArray];
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    }];
}

- (void)setCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"BBSListCell" bundle:nil] forCellReuseIdentifier:@"BBSListCell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     BBSListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBSListCell"];
    cell.topic = self.topics[indexPath.row];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BBSListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BBSListCell"];
    cell.topic = self.topics[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BBsDetailViewController *bbsDetailVC = [[BBsDetailViewController alloc] init];
    bbsDetailVC.topic = self.topics[indexPath.row];
    [self pushViewController:bbsDetailVC];
}

- (IBAction)topBtnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    for (NSLayoutConstraint *constraint in self.topView.constraints) {
        if (constraint.firstItem == self.blueLabel && constraint.firstAttribute == NSLayoutAttributeLeading) {
            constraint.constant = 15 + (30 + 60) *(btn.tag - 1);
        }
    }
    [UIView animateWithDuration:0.35 animations:^{
        [self.topView layoutIfNeeded];
        [self.topView updateConstraintsIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end
