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
@property(nonatomic, strong)CCHttpManager *httpManager;
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
-(void)sureMessage
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager addAppMessageWithTitle:@"没电了" Conten:@"还是每天这样的啊" ReceiveUserIDs:@[@183] finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                [MBProgressHUD showSuccess:self.reob.errorMessage];
                [self.navigationController popViewControllerAnimated:YES];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
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
