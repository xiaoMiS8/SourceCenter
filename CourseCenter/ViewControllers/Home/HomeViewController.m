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
#import "TestViewController.h"
#import "ResponseObject.h"
#import "NSString+HandleString.h"
@interface HomeViewController ()
{
    NSString *loginState;
    NSString *userId;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *courseSelectLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginPrompt;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (nonatomic, assign) CGFloat startY;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isLoginOrCourse) name:@"loginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isLoginOrCourse) name:@"logout" object:nil];
    [self setupTableView];
    _loginBtn.layer.masksToBounds=YES;
    _loginBtn.layer.cornerRadius=5;
    self.courseSelectLabel.text = @"推荐课程";
    self.httpManager = [[CCHttpManager alloc]init];
    self.dataArray=[[NSMutableArray array]init];
    [self isLoginOrCourse];
}

-(void)isLoginOrCourse
{
    loginState=[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    if ([loginState isEqualToString:@"0"]||loginState==nil) {
        _tableView.hidden=YES;
        _loginBtn.hidden=NO;
        _loginPrompt.hidden=NO;
    }else
    {
        _tableView.hidden=NO;
        _loginBtn.hidden=YES;
        _loginPrompt.hidden=YES;
        [self rLoadData];
    }
}
//推荐课程
-(void)rLoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getRecommendCourseListWithfinished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.dataArray=self.reob.resultArray;
                [_tableView reloadData];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
//全部课程
-(void)aLoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getOCAllListWithSpecialtyTypeID:-1 key:nil PageIndex:1 PageSize:INT_MAX finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.dataArray=self.reob.resultArray;
                [_tableView reloadData];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
- (IBAction)testAction:(id)sender {
     TestViewController*testVC = [TestViewController new];
    [((AppDelegate *)app).nav pushViewController:testVC animated:YES];
}
- (IBAction)gotoLogin:(UIButton *)sender {
    LoginViewController *loginSearchVC = [LoginViewController new];
    loginSearchVC.block=^()
    {
        ((AppDelegate *)app).tabar.OneLoginState=@"1";
        //[self isLoginOrCourse];
    };
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
    if ([loginState isEqualToString:@"0"]||loginState==nil) {
        [Tool showAlertView:@"提示" withMessage:@"请先登录!" withTarget:self withCancel:@"确定" other:nil];
    }else
    {
        CourseSearchViewController *courseSearchVC = [CourseSearchViewController new];
        [((AppDelegate *)app).nav pushViewController:courseSearchVC animated:YES];
    }
    
}

- (void)segValueChange:(UISegmentedControl *)seg {
    if (seg.selectedSegmentIndex == 0) {
        self.courseSelectLabel.text = @"推荐课程";
        if ([loginState isEqualToString:@"1"]) {
            [self rLoadData];
        }
    }
    else {
        self.courseSelectLabel.text = @"全部课程";
        if ([loginState isEqualToString:@"1"]) {
            [self aLoadData];
        }
    }
}

#pragma mark- UItableViewDelegate && UITableViewDatasource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     HomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeListCell"];
     CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return cellSize.height + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeListCell"];
    cell.hVC=self;
    cell.oCourse=[self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeDetailViewController *homeDetailVc = [[HomeDetailViewController alloc]init];
    homeDetailVc.OCID=((OCourseInfo *)[self.dataArray objectAtIndex:indexPath.row]).OCID;
    homeDetailVc.teacherImgUrl=((OCourseInfo *)[self.dataArray objectAtIndex:indexPath.row]).TeacherImgUrl;
    homeDetailVc.topImgUrl=((OCourseInfo *)[self.dataArray objectAtIndex:indexPath.row]).CourseImgUrl;
    homeDetailVc.RegStatus=((OCourseInfo *)[self.dataArray objectAtIndex:indexPath.row]).RegStatus;
    [((AppDelegate *)app).nav pushViewController:homeDetailVc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY - _startY > 10) {
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
    else if (offsetY - _startY < -10)
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
