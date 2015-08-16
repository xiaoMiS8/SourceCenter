//
//  LoginViewController.m
//  CourseCenter
//
//  Created by Mac on 15-5-27.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "LoginViewController.h"
#import "FindPasswordViewController.h"
#import "ResponseObject.h"
#import "NSString+HandleString.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (strong,nonatomic)UserInfo *userInfo;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    _loginBtn.layer.masksToBounds=YES;
    _loginBtn.layer.cornerRadius=5;
    _userName.allowsEditingTextAttributes=YES;
    _userName.clearButtonMode=UITextFieldViewModeWhileEditing;
    _passWord.secureTextEntry=YES;
    _passWord.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.httpManager = [[CCHttpManager alloc]init];
}
- (IBAction)login:(UIButton *)sender {
    NSString *username=_userName.text;
    NSString *password=_passWord.text;
    if ([_userName.text isNull]||[_passWord.text isNull]) {
        [MBProgressHUD showError:LOGINMESSAGE];
        return;
    }
    [MBProgressHUD showMessage:nil];
    [self.httpManager loginWithLoginName:username Pwd:password finished:^(EnumServerStatus status, NSObject *object) {
    [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"isLogin"];
                UserInfo *info=(UserInfo *)self.reob.resultObject;
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",info.userType] forKey:@"role"];
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",info.userID]forKey:@"userID"];
<<<<<<< HEAD
=======
                [[NSUserDefaults standardUserDefaults] setObject:info.userImg forKey:@"userImg"];
>>>>>>> 7988db939b9c6c3b33f3106d26acf496b1afb779
//                [[NSUserDefaults standardUserDefaults]setObject:password forKey:@"password"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                if (self.block) {
                    self.block();
                }
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
            [MBProgressHUD showError:LOGINMESSAGE_B];
            return ;
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
        
    }];
    
}
- (IBAction)forgetPassword:(UIButton *)sender {
    FindPasswordViewController *findPassword = [FindPasswordViewController new];
    [((AppDelegate *)app).nav pushViewController:findPassword animated:YES];

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
