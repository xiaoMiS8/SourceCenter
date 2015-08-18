//
//  SetViewController.m
//  CourseCenter
//
//  Created by 2345 on 15/7/12.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "SetViewController.h"
#import "MyInfo.h"
#import "SetPassword.h"
#import "IdeaWithVersion.h"
@interface SetViewController ()
{
    MyInfo *myInfo;
    SetPassword *passWord;
    IdeaWithVersion *idea;
    IdeaWithVersion *version;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *exitBtn;
@property(nonatomic, strong) CCHttpManager * httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"设置";
    self.exitBtn.layer.masksToBounds=YES;
    self.exitBtn.layer.cornerRadius=5;
    self.httpManager = [[CCHttpManager alloc]init];
    myInfo=[[MyInfo alloc]init];
    passWord=[[SetPassword alloc]init];
    idea=[[IdeaWithVersion alloc]init];
    version=[[IdeaWithVersion alloc]init];

}
-(void)viewWillAppear:(BOOL)animated
{
    NSString *loginState=[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    if ([loginState isEqualToString:@"0"]||loginState==nil) {
        self.exitBtn.hidden=YES;
        return;
    }
        self.exitBtn.hidden=NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"Identifier";
    static NSString *IdentifierKeyWithSwitch=@"IdentifierKeyWithSwitch";
    UITableViewCell *cell;
    if (indexPath.row==2) {
        cell=[tableView dequeueReusableCellWithIdentifier:IdentifierKeyWithSwitch];
    }else{
        cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    if(!cell){
        if (indexPath.row==2) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:IdentifierKeyWithSwitch];
            UILabel *versionLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
            versionLable.text=@"检查更新";
            versionLable.layer.masksToBounds=YES;
            versionLable.layer.cornerRadius=5;
            versionLable.backgroundColor=[UIColor orangeColor];
            cell.accessoryView=versionLable;
            
        }else{
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text=@"更改密码";
            break;
        case 1:
            cell.textLabel.text=@"个人信息";
            break;
        case 2:
            cell.textLabel.text=@"关于课程中心";
            cell.detailTextLabel.text=@"course center 2.1";
            cell.detailTextLabel.font=[UIFont systemFontOfSize:12];
            break;
        case 3:
            cell.textLabel.text=@"新版吐槽";
            break;
        default:
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击松开后,颜色恢复
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [((AppDelegate *)app).nav pushViewController:passWord animated:YES];
            break;
        case 1:
            myInfo.userInfo=self.userInfo;
            [((AppDelegate *)app).nav pushViewController:myInfo animated:YES];
            break;
        case 2:
            version.isIdea=@"NO";
            [((AppDelegate *)app).nav pushViewController:version animated:YES];
            break;
        case 3:
            idea.isIdea=@"YES";
            [((AppDelegate *)app).nav pushViewController:idea animated:YES];
            break;
        default:
            break;
    }
}
- (IBAction)exit:(UIButton *)sender {
    [MBProgressHUD showMessage:nil];
    [self.httpManager LogoutWithfinished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"isLogin"];
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"role"];
                [MBProgressHUD showSuccess:self.reob.errorMessage];
                //退出回调刷新页面
                if (self.block) {
                    _block();
                }
                ((AppDelegate *)app).tabar.FourLoginState=@"0";
                [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
            [MBProgressHUD showError:LOGINMESSAGE_F];
        }
    }];
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
