//
//  LoginViewController.m
//  CourseCenter
//
//  Created by Mac on 15-5-27.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "LoginViewController.h"
#import "FindPasswordViewController.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

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
}
- (IBAction)login:(UIButton *)sender {
    
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
