//
//  HWorkDetailViewController.m
//  CourseCenter
//
//  Created by muzhenhua on 15/8/5.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "HWorkDetailViewController.h"

@interface HWorkDetailViewController ()
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation HWorkDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.httpManager = [[CCHttpManager alloc]init];
    self.dataArray=[[NSMutableArray array]init];
    [self setupCustomLeftWithtitle:@"暂存" target:self action:@selector(save)];
    [self setupCustomRightWithtitle:@"提交" target:self action:@selector(submit)];
   // [self LoadData];
}
-(void)LoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getPaperInfoWithPaperID:151
     TestID:213 finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.dataArray=self.reob.resultArray;
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}

-(void)save{
    
}
-(void)submit
{
    
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
