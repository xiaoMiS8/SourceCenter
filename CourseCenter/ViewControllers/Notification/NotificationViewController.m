//
//  NotificationViewController.m
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotificationListCell.h"
#import "NotificationInfo.h"
#import "NotiDetailViewController.h"
#import "NewNotificationViewController.h"
#import "LineNavigationController.h"
#import "CCHttpManager.h"
#import "ResponseObject.h"
#import "LoginViewController.h"
#import "MJRefresh.h"
@interface NotificationViewController ()
{
    NSString *loginState;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) CCHttpManager *httpManager;

@property(nonatomic, strong) NSMutableArray *notis;
@property(nonatomic, assign) int index;

@end

@implementation NotificationViewController


- (void)setAddBtn:(UIButton *)addBtn {
    _addBtn = addBtn;
    [addBtn addTarget:self
               action:@selector(addBtnAction:)
     forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 1;
    [self setupTable];
    _loginBtn.layer.masksToBounds=YES;
    _loginBtn.layer.cornerRadius=5;
    [self isLogin];
    [self addtableHeader];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self isLogin];
}

-(void)isLogin
{
    
    loginState=[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    if ([loginState isEqualToString:@"0"]||loginState==nil) {
        _tableView.hidden=YES;
        _loginBtn.hidden=NO;
        _Message.hidden=NO;
    }else
    {
        _tableView.hidden=NO;
        _loginBtn.hidden=YES;
        _Message.hidden=YES;
        [self loadData];
    }
}

- (void)addtableHeader {
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [self loadMore];
    }];
    self.tableView.header.updatedTimeHidden = YES;
}


- (void)loadData
{
    
    self.index = 1;
    self.httpManager = [[CCHttpManager alloc] init];
    [MBProgressHUD showMessage:@"正在加载"];
    [self.httpManager getNoticeInfoListWithOCID:2 SysID:1 ModuleID:-1 PageIndex:self.index PageSize:10 finished:^(EnumServerStatus status, NSObject *object) {
        if (status == Enum_SUCCESS) {
            [MBProgressHUD hideHUD];
            ResponseObject *responseObject = (ResponseObject *)object;
            self.notis = responseObject.resultArray;
            [self.tableView reloadData];
            [self.tableView.legendHeader endRefreshing];
        }
    }];
}

- (void)loadMore {
    self.index ++;
    self.httpManager = [[CCHttpManager alloc] init];
    [self.httpManager getNoticeInfoListWithOCID:2 SysID:1 ModuleID:-1 PageIndex:self.index PageSize:10 finished:^(EnumServerStatus status, NSObject *object) {
        if (status == Enum_SUCCESS) {
            ResponseObject *responseObject = (ResponseObject *)object;
            [self.notis addObjectsFromArray:responseObject.resultArray];
            [self.tableView reloadData];
            [self.tableView.legendFooter endRefreshing];
        }
    }];
}

- (void)setupTable
{
     self.tableView.backgroundColor = [Tool bgColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     [self setupCell];
}

- (void)setupCell {
    [self.tableView registerClass:[NotificationListCell class] forCellReuseIdentifier:@"NotificationListCell"];
}

    //添加通知
- (void)addBtnAction:(id)sender {
    NewNotificationViewController *newNotificationVC = [NewNotificationViewController new];
    newNotificationVC.DoBlock = ^{
        DLog(@"点击确定了");
    };
    LineNavigationController *nav = [[LineNavigationController alloc] initWithRootViewController:newNotificationVC];
    UIViewController *tabbar = ((AppDelegate *)app).nav.viewControllers.firstObject;
    [tabbar presentViewController:nav animated:YES completion:^{
        
          }];

    
}

- (IBAction)gotoLogin:(UIButton *)sender {
    LoginViewController *loginSearchVC = [LoginViewController new];
    loginSearchVC.block=^()
    {
        [self isLogin];
    };
    [((AppDelegate *)app).nav pushViewController:loginSearchVC animated:YES];
}

#pragma mark- UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notis.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationListCell"];
    cell.noticeInfo = self.notis[indexPath.row];
    return cell.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationListCell"];
    cell.noticeInfo = self.notis[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NotiDetailViewController *notiDetailVC = [[NotiDetailViewController alloc] init];
    notiDetailVC.noticeInfo = self.notis[indexPath.row];
    [((AppDelegate *)app).nav pushViewController:notiDetailVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
