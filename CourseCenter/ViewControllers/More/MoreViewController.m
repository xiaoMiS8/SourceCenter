//
//  MoreViewController.m
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreListCell.h"
#import "MyInfo.h"
#import "SetViewController.h"
#import "MessageCenter.h"
#import "MyData.h"
#import "UserInfo.h"
@interface MoreViewController ()
{
    NSArray *myarray;
    MyInfo *myInfo;
    SetViewController *set;
    MessageCenter *messageCenter;
    MyData *myData;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;
@property(nonatomic, strong)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (strong,nonatomic)UserInfo *userInfo;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (SHeight<=480) {
        _tableHeight.constant=365;
    }else
    {
        _tableHeight.constant=450;
        _tableView.scrollEnabled=NO;
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"MoreListCell" bundle:nil] forCellReuseIdentifier:@"MoreListCell"];
    myInfo=[[MyInfo alloc]init];
    set=[[SetViewController alloc]init];
    messageCenter=[[MessageCenter alloc]init];
    myData=[[MyData alloc]init];
    self.httpManager=[[CCHttpManager alloc]init];
    [self loadMyInfo];
}
-(void)loadMyInfo
{
    [self.httpManager getUserInfoWithfinished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.userInfo=self.reob.resultObject;
                [_tableView reloadData];
            }
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            return 4;
        case 3:
            return 1;
        default:
            return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 60;
        }
    }
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击松开后,颜色恢复
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            myInfo.userInfo=self.userInfo;
            [((AppDelegate *)app).nav pushViewController:myInfo animated:YES];
            break;
        case 1:
            [((AppDelegate *)app).nav pushViewController:messageCenter animated:YES];
            break;
        case 2:
            [self chooseViewControllerWithindexPath:indexPath];
            break;
        case 3:
            [((AppDelegate *)app).nav pushViewController:set animated:YES];
            break;
        default:
            break;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreListCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"MoreListCell"];
    if(self.userInfo!=nil)
    {
    cell.userInfo=self.userInfo;
    }
    cell.indexPath=indexPath;
    return cell;
}
-(void)chooseViewControllerWithindexPath:(NSIndexPath *)index
{
    switch (index.row) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            [((AppDelegate *)app).nav pushViewController:myData animated:YES];
            break;
        case 3:
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
