//
//  SendMesage.m
//  CourseCenter
//
//  Created by 2345 on 15/7/18.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "SendMesage.h"

@interface SendMesage ()
@property(nonatomic,strong)NSMutableArray *tags;
@property (weak, nonatomic) IBOutlet UITextField *textF;
@property(nonatomic, strong)CCHttpManager *httpManager;
@property (weak, nonatomic) IBOutlet UITextView *textV;
@property (strong,nonatomic)ResponseObject *reob;
@end

@implementation SendMesage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"新建消息";
    [self setupCustomRightWithtitle:@"发送" target:self action:@selector(sureMessage)];
    self.httpManager = [[CCHttpManager alloc]init];
    _tags=[[NSMutableArray alloc]init];
    [self loadData];
    _editingTagControl.tags = [_tags mutableCopy];
    _editingTagControl.data=[self returnSelectArray];
    _editingTagControl.tagPlaceholder=@"";
    [_editingTagControl reloadTagSubviews];
}
-(void)loadData
{
    NSMutableArray *muArray=[self returnSelectArray];
    for (int i=0; i<muArray.count; i++) {
        NSString *name=[muArray[i] objectForKey:@"UserName"];
        [_tags addObject:name];
    }
}
-(NSMutableArray *)returnSelectArray
{
    NSMutableArray *mArray=[[NSMutableArray alloc]init];
    for (int i=0; i<((AppDelegate *)app).dicData.count; i++) {
        NSArray *array=[((AppDelegate *)app).dicData objectForKey:[NSString stringWithFormat:@"%d",i]];
        for (int j=0; j<array.count; j++) {
            if ([array[j]isEqualToString:@"SEL"]) {
                [mArray addObject:[((NSArray *)[_array objectAtIndex:i])objectAtIndex:j]];
            }
        }
    }
    return mArray;
}
-(NSString *)getArrayId
{
    NSString *arrayIds=@"";
    NSString *string=nil;
    for (int i=0; i<_editingTagControl.data.count; i++) {
        string=[NSString stringWithFormat:@"%@,",[[_editingTagControl.data[i] objectForKey:@"UserID"]stringValue]];
        arrayIds=[arrayIds stringByAppendingString:string];
    }
    return arrayIds;
}
-(void)sureMessage
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager addAppMessageWithTitle:_textF.text Conten:_textV.text ReceiveUserIDs:[self getArrayId] finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                [MBProgressHUD showSuccess:self.reob.errorMessage];
                [self.navigationController popToViewController:_messageCenter animated:YES];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入内容(必填)"]) {
        textView.text=@"";
        textView.textColor=RGBA(0, 0, 0, 1);
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text=@"请输入内容(必填)";
        textView.textColor=RGBA(193, 193, 194, 1);
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
