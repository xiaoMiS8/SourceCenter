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
#import "LoginViewController.h"
#import "CourseTabbarViewController.h"
#import "TutorialViewController.h"
#import "FCourseViewController.h"
#import "BBsViewController.h"
#import "HWorkViewController.h"
#import "TPViewController.h"
#import "LineNavigationController.h"
#import "ReadViewController.h"
#import "UIImageView+WebCache.h"
static NSInteger number=0;
@interface CourseViewController ()
{
    NSString *loginState;
    NSString *userId;
}
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *loginPrompt;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(nonatomic, strong) CCHttpManager *manager;
@property(nonatomic, strong) NSMutableArray *OCList;

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isLoginOrCourse) name:@"loginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isLoginOrCourse) name:@"logout" object:nil];
    _loginBtn.layer.masksToBounds=YES;
    _loginBtn.layer.cornerRadius=5;
    [self initmanager];
    [self setCell];
    [self isLoginOrCourse];
    
  
}
-(void)isLoginOrCourse
{
    loginState=[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    if ([loginState isEqualToString:@"0"]||loginState==nil) {
        _tableView.hidden=YES;
        _loginBtn.hidden=NO;
        _loginPrompt.hidden=NO;
        _topLabel.hidden=YES;
    }else
    {
        _tableView.hidden=NO;
        _loginBtn.hidden=YES;
        _loginPrompt.hidden=YES;
        _topLabel.hidden=NO;
        [self loadData];
    }
}
- (void)setCenterImg:(UIImageView *)centerImg {
    _centerImg = centerImg;
    NSString *userImg = [[NSUserDefaults standardUserDefaults] objectForKey:@"userImg"];
    [centerImg sd_setImageWithURL:[NSURL URLWithString:userImg] placeholderImage:[UIImage imageNamed:@"iconpro"]];
}

- (void)initmanager {
    self.manager = [CCHttpManager new];
}

- (void)loadData {
    if (number==1) {
        [MBProgressHUD showMessage:nil];
    }
    [self.manager getAppOCListWithIsHistroy:0 finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        ResponseObject *retunObject = (ResponseObject *)object;
        self.OCList = retunObject.resultArray;
        [self.tableView reloadData];
    }];
    number=1;
}

- (void)setCell {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCourseListCell" bundle:nil] forCellReuseIdentifier:@"MyCourseListCell"];
}

#pragma mark- UITableViewDataSource & UITableDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [((AppDelegate *)app).nav pushViewController:[self setTabbarWithindexPath:indexPath] animated:YES];
    
}

- (CourseTabbarViewController *)setTabbarWithindexPath:(NSIndexPath *)index {
    CourseTabbarViewController *tabbar = [[CourseTabbarViewController alloc] init];
    TutorialViewController *tutoriaVC = [[TutorialViewController alloc] init];
    tutoriaVC.OCID=((OCourseInfo *)self.OCList[index.row]).OCID;
    tutoriaVC.PushBlock = ^(UIViewController *viewController) {
        [tabbar.navigationController pushViewController:viewController animated:YES];
    };
    FCourseViewController *fCourseVC = [[FCourseViewController alloc] init];
    fCourseVC.ocourse = self.OCList[index.row];
    fCourseVC.PushBlock = ^(UIViewController *viewController) {
        [tabbar.navigationController pushViewController:viewController animated:YES];
    };
    BBsViewController *bbsVC = [[BBsViewController alloc] init];
    bbsVC.OCID = ((OCourseInfo *)(self.OCList[index.row])).OCID;
    bbsVC.PushBlock = ^(UIViewController *viewController) {
        [tabbar.navigationController pushViewController:viewController animated:YES];
    };
    HWorkViewController *hworkVC = [[HWorkViewController alloc] init];
    hworkVC.OCID=((OCourseInfo *)(self.OCList[index.row])).OCID;
    hworkVC.PushBlock = ^(UIViewController *viewController) {
        [tabbar.navigationController pushViewController:viewController animated:YES];
    };
    ReadViewController *readVC = [ReadViewController new];
    readVC.OCID = ((OCourseInfo *)(self.OCList[index.row])).OCID;
    
    
    TPViewController *tpVC = [[TPViewController alloc] init];
    tpVC.OCID=((OCourseInfo *)(self.OCList[index.row])).OCID;
    tpVC.PushBlock = ^(UIViewController *viewController) {
        [tabbar.navigationController pushViewController:viewController animated:YES];
    };
    
    NSArray *viewControllers = nil;
    NSArray *titles = nil;
    NSArray *itemImages = nil;
    NSArray *itemSelectedImages = nil;
    
    NSString *role = [[NSUserDefaults standardUserDefaults]objectForKey:@"role"];
    if (![role isEqualToString:@"4"]) {
        viewControllers = @[tutoriaVC, fCourseVC,bbsVC, hworkVC, tpVC];
        titles = @[@"教程",@"翻转课堂",@"论坛",@"作业",@"事务处理"];
        itemImages = @[@"cTabbar1_n",@"cTabbar2_n",@"cTabbar3_n",@"cTabbar4_n",@"cTabbar5_n"];
        itemSelectedImages = @[@"cTabbar1_s",@"cTabbar2_s",@"cTabbar3_s",@"cTabbar4_s",@"cTabbar5_s"];
     
    } else {
        viewControllers = @[tutoriaVC, fCourseVC,bbsVC, readVC, tpVC];
        titles = @[@"教程",@"翻转课堂",@"论坛",@"批阅",@"事务处理"];
        itemImages = @[@"cTabbar1_n",@"cTabbar2_n",@"cTabbar3_n",@"cTabbar4_n",@"cTabbar5_n"];
        itemSelectedImages = @[@"cTabbar1_s",@"cTabbar2_s",@"cTabbar3_s",@"cTabbar4_s",@"cTabbar5_s"];
    }
    
    [tabbar setViewcontrollers:viewControllers itemImages:itemImages itemselectedImages:itemSelectedImages titles:titles];
    return tabbar;
    
}
- (IBAction)gotoLogin:(UIButton *)sender {
    LoginViewController *loginSearchVC = [LoginViewController new];
    loginSearchVC.block=^()
    {
        ((AppDelegate *)app).tabar.ThreeLoginState=@"1";
       // [self isLoginOrCourse];
    };
    [((AppDelegate *)app).nav pushViewController:loginSearchVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
