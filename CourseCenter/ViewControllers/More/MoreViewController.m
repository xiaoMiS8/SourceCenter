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
#import "LoginViewController.h"
#import "MsgInfo.h"
#import "QuestionSurvey.h"
#import "MyDownLoad.h"
@interface MoreViewController ()
{
    NSArray *myarray;
    MyInfo *myInfo;
    SetViewController *set;
    MessageCenter *messageCenter;
    MyData *myData;
    QuestionSurvey *questionSurvey;
    MyDownLoad *myDownload;
    NSString *loginState;
    __block  BOOL isBlock;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;
@property (weak, nonatomic) IBOutlet UILabel *loginPrompt;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(nonatomic, strong)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (strong,nonatomic)UserInfo *userInfo;
@property (strong,nonatomic)MsgInfo *msgInfo;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isLoginOrCourse) name:@"loginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isLoginOrCourse) name:@"logout" object:nil];
    _loginBtn.layer.masksToBounds=YES;
    _loginBtn.layer.cornerRadius=5;
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
    questionSurvey=[[QuestionSurvey alloc]init];
    self.httpManager=[[CCHttpManager alloc]init];
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
        [self loadMyInfo];
    }
}

-(void)loadMyInfo
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getUserInfoWithfinished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.userInfo=self.reob.resultObject;
                [_tableView reloadData];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
        [MBProgressHUD hideHUD];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.httpManager getAppUnReadMessageCountWithfinished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.msgInfo=self.reob.resultObject;
                [_tableView reloadData];
                return ;
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
            return 3;
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
    __block typeof (self) myself =self;
    switch (indexPath.section) {
        case 0:
            myInfo.userInfo=self.userInfo;
            [((AppDelegate *)app).nav pushViewController:myInfo animated:YES];
            break;
        case 1:
            messageCenter=[[MessageCenter alloc]init];
            [((AppDelegate *)app).nav pushViewController:messageCenter animated:YES];
            break;
        case 2:
            [self chooseViewControllerWithindexPath:indexPath];
            break;
        case 3:
            set.block=^()
          {
         [myself isLoginOrCourse];
          };
            set.userInfo=self.userInfo;
            [((AppDelegate *)app).nav pushViewController:set animated:YES];
            break;
        default:
            break;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreListCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"MoreListCell"];
    if(self.userInfo!=nil&&self.msgInfo!=nil)
    {
    cell.userInfo=self.userInfo;
    cell.msgInfo=self.msgInfo;
    }
    cell.indexPath=indexPath;
    return cell;
}
-(void)chooseViewControllerWithindexPath:(NSIndexPath *)index
{
    switch (index.row) {
        case 0:
            [((AppDelegate *)app).nav pushViewController:questionSurvey animated:YES];
            break;
        case 1:
            myData=[[MyData alloc]init];
            [((AppDelegate *)app).nav pushViewController:myData animated:YES];
            break;
        case 2:
            myDownload=[[MyDownLoad alloc]init];
            [((AppDelegate *)app).nav pushViewController:myDownload animated:YES];
            break;
//        case 3:
//            break;
        default:
            break;
    }
}
- (IBAction)gotoLogin:(UIButton *)sender {
    
    if ([Tool objectIsEmpty:[[NSUserDefaults standardUserDefaults]objectForKey:@"schoolUrl"]]) {
        [Tool showAlertView:@"提示" withMessage:@"请先选择学校!" withTarget:nil withCancel:@"确定" other:nil];
    }else
    {
        LoginViewController *loginSearchVC = [LoginViewController new];
        loginSearchVC.block=^()
        {
            ((AppDelegate *)app).tabar.FourLoginState=@"1";
            [self isLoginOrCourse];
        };
        [((AppDelegate *)app).nav pushViewController:loginSearchVC animated:YES];
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
