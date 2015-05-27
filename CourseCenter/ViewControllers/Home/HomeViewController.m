//
//  HomeViewController.m
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeListCell.h"
#import "HomeDetailViewController.h"
#import "CourseSearchViewController.h"
#import "LoginViewController.h"
@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *courseSelectLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginPrompt;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property(nonatomic, assign) CGFloat startY;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    _loginBtn.layer.masksToBounds=YES;
    _loginBtn.layer.cornerRadius=5;
    self.courseSelectLabel.text = @"推荐课程";
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString *loginState=[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    if (![loginState isEqualToString:@"1"]) {
       [_tableView removeFromSuperview];
    }
}
- (IBAction)gotoLogin:(UIButton *)sender {
    LoginViewController *loginSearchVC = [LoginViewController new];
    [((AppDelegate *)app).nav pushViewController:loginSearchVC animated:YES];
}

- (void)setSeg:(UISegmentedControl *)seg
{
    _seg = seg;
    [seg addTarget:self action:@selector(segValueChange:) forControlEvents:UIControlEventValueChanged];
}



- (void)setSearchBtn:(UIButton *)searchBtn
{
    _searchBtn = searchBtn;
    [self addbSearchBtnAction];
}

- (void)addbSearchBtnAction
{
    [self.searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupCustomCell];
}


- (void)setupCustomCell
{
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeListCell" bundle:nil] forCellReuseIdentifier:@"HomeListCell"];
}

- (void)search
{
    CourseSearchViewController *courseSearchVC = [CourseSearchViewController new];
    [((AppDelegate *)app).nav pushViewController:courseSearchVC animated:YES];
}

- (void)segValueChange:(UISegmentedControl *)seg {
    if (seg.selectedSegmentIndex == 0) {
        self.courseSelectLabel.text = @"推荐课程";
    }
    else {
        self.courseSelectLabel.text = @"全部课程";
    }
}

#pragma mark- UItableViewDelegate && UITableViewDatasource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     HomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeListCell"];
     CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return cellSize.height + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeListCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeDetailViewController *homeDetailVc = [HomeDetailViewController new];
    [((AppDelegate *)app).nav pushViewController:homeDetailVc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY - _startY > 3) {
        for (NSLayoutConstraint *constraint in self.view.constraints) {
            if (constraint.firstItem == self.topView &&
                constraint.firstAttribute == NSLayoutAttributeTop) {
                constraint.constant = - 60;
            }
        }
        [UIView animateWithDuration:.25 animations:^{
            [self.view layoutIfNeeded];
            [self.view updateConstraintsIfNeeded];
        }];
    }
    else if (offsetY - _startY < -3)
    {
        for (NSLayoutConstraint *constraint in self.view.constraints) {
            if (constraint.firstItem == self.topView &&
                constraint.firstAttribute == NSLayoutAttributeTop) {
                constraint.constant = 0;
            }
        }
        [UIView animateWithDuration:.25 animations:^{
            [self.view layoutIfNeeded];
            [self.view updateConstraintsIfNeeded];
        }];
    }
   
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.startY = scrollView.contentOffset.y;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
