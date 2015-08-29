//
//  TPViewCell.m
//  CourseCenter
//
//  Created by muzhenhua on 15/8/5.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "TPViewCell.h"

@implementation TPViewCell

- (void)awakeFromNib {
    // Initialization code
    _btn1.layer.borderColor=[UIColor grayColor].CGColor;
    _btn1.layer.borderWidth=0.5;
    _btn2.layer.borderColor=[UIColor grayColor].CGColor;
    _btn2.layer.borderWidth=0.5;
    self.httpManager = [[CCHttpManager alloc]init];
}
-(void)setInfo:(AffairInfo *)info
{
    if (_info!=info) {
        _info=info;
    }
    _btn1.tag=_indexPath.row;
    _btn2.tag=_indexPath.row;
  //  _label1.text=_info.AffairType;
    _label2.text=_info.CreateDate;
    _label3.text=_info.UserName;
    _label4.text=_info.ClassName;
    _label5.text=_info.AffairDesc;
    _label6.text=_info.Reson;
}
- (IBAction)refuse:(UIButton *)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"你确定要拒绝吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=100;
    [alert show];
}
- (IBAction)agree:(UIButton *)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"你确定要同意吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=101;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==100) {
        if (buttonIndex==1) {
            [self checkWithStatus:1];
        }
    }
    if (alertView.tag==101) {
        if (buttonIndex==1) {
            [self checkWithStatus:2];
        }
    }
}
-(void)checkWithStatus:(int)status
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager updateOCAffairsStatusWithAffairID:_info.AffairID Status:status finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                [MBProgressHUD showSuccess:self.reob.errorMessage];
                [_tpVC LoadData];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
