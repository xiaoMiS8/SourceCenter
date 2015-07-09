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
@interface NotificationViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) CCHttpManager *httpManager;

@property(nonatomic, strong) NSMutableArray *notis;

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
    [self setupTable];
    [self loadData];
    
}


- (void)loadData
{
    
    
    self.httpManager = [[CCHttpManager alloc] init];
    [self.httpManager getNoticeInfoListWithOCID:2 SysID:1 ModuleID:-1 PageIndex:1 PageSize:10 finished:^(EnumServerStatus status, NSObject *object) {
        ResponseObject *responseObject = (ResponseObject *)object;
        self.notis = responseObject.resultArray;
        [self.tableView reloadData];
    }];
    
//    self.notis = [[NSMutableArray alloc] init];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"notificationInfos" ofType:@"plist"];
//    NSArray *array = [NSArray arrayWithContentsOfFile:path];
//    for (int i=0; i<array.count; i++) {
//        NotificationInfo *not = [[NotificationInfo alloc] initDict:array[i]];
//        [self.notis addObject:not];
//    }
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
