//
//  SetPassword.m
//  CourseCenter
//
//  Created by 2345 on 15/7/12.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "SetPassword.h"
#import "NSString+HandleString.h"
@interface SetPassword ()
@property (nonatomic,strong)NSMutableArray *textFieldarray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) CCHttpManager * httpManager;
@property(nonatomic, strong) ResponseObject *reob;
@end

@implementation SetPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"修改密码";
    [self setupCustomRightWithtitle:@"确定" target:self action:@selector(savePassword)];
    self.httpManager = [[CCHttpManager alloc]init];
    self.textFieldarray=[[NSMutableArray alloc]init];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    ((UITextField *)_textFieldarray[0]).text=@"";
    ((UITextField *)_textFieldarray[1]).text=@"";
    ((UITextField *)_textFieldarray[2]).text=@"";
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cellID";
    //首先根据标示去缓存池取
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    //如果缓存池没有取到则重新创建并放到缓存池中
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
        textField.placeholder=@"请输入密码";
        textField.tag=indexPath.row;
        textField.secureTextEntry=YES;
        [_textFieldarray addObject:textField];
        cell.accessoryView=textField;
}
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text=@"原密码";
            break;
        case 1:
            cell.textLabel.text=@"新密码";
            break;
        case 2:
            cell.textLabel.text=@"确认密码";
            break;
        default:
            break;
    }
    return cell;
}
-(void)savePassword
{
    if (![self textFieldverify]) {
        return;
    }
    NSString *Old= ((UITextField *)_textFieldarray[0]).text;
    NSString *new= ((UITextField *)_textFieldarray[1]).text;
    [self.httpManager  updatePassWordWithYpwd:Old NPwd:new finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                [MBProgressHUD showSuccess:self.reob.errorMessage];
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
            [MBProgressHUD showError:self.reob.errorMessage];
                return;
        }
         [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
-(BOOL)textFieldverify
{
    [MBProgressHUD showMessage:nil];
    NSString *Old= ((UITextField *)_textFieldarray[0]).text;
    NSString *new= ((UITextField *)_textFieldarray[1]).text;
    NSString *newAgain= ((UITextField *)_textFieldarray[2]).text;
    if ([Old isNull]) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"原密码不能为空!"];
        return NO;
    }
    if ([new isNull]) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"新密码不能为空!"];
        return NO;
    }
    if ([newAgain isNull]) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"确认密码不能为空!"];
        return NO;
    }
    if (![new isEqualToString:newAgain]) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"新密码和确认密码不一样!"];
        return NO;
    }
    return YES;
    
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
