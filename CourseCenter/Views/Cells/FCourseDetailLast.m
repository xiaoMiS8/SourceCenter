//
//  FCourseDetailLast.m
//  CourseCenter
//
//  Created by muzhenhua on 15/8/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "FCourseDetailLast.h"

@implementation FCourseDetailLast

- (void)awakeFromNib {
    // Initialization code
    self.contentView.layer.borderColor=[UIColor grayColor].CGColor;
    self.contentView.layer.borderWidth=1;
}
-(void)setFrInfo:(FRankInfo *)frInfo
{
    if(_frInfo!=frInfo)
    {
        _frInfo=frInfo;
    }
    _totalP.text=[NSString stringWithFormat:@"我的(共%d人)",_cgInfo.UserCount];
    _totalG.text=[NSString stringWithFormat:@"小组(共%d组)",_cgInfo.GroupCount];
    _myL1.text=[NSString stringWithFormat:@"%.2f",_frInfo.myrank.FileScore];
    _myL2.text=[NSString stringWithFormat:@"%.2f",_frInfo.myrank.TestScore];
    _myL3.text=[NSString stringWithFormat:@"%.2f",_frInfo.myrank.ForumScore];
    _myL4.text=[NSString stringWithFormat:@"%.2f",_frInfo.myrank.SigninScore];
    _myL5.text=[NSString stringWithFormat:@"%.2f",_frInfo.myrank.OfflineScore];
    _myL6.text=[NSString stringWithFormat:@"%.2f",_frInfo.myrank.EvaluationScore];
    _myL7.text=[NSString stringWithFormat:@"%.2f",_frInfo.myrank.AllScore];
    _myL8.text=[NSString stringWithFormat:@"%d",_frInfo.myrank.MyRank];
    _groupL1.text=[NSString stringWithFormat:@"%.2f",_frInfo.grouprank.FileScore];
    _groupL2.text=[NSString stringWithFormat:@"%.2f",_frInfo.grouprank.TestScore];
    _groupL3.text=[NSString stringWithFormat:@"%.2f",_frInfo.grouprank.ForumScore];
    _groupL4.text=[NSString stringWithFormat:@"%.2f",_frInfo.grouprank.SigninScore];
    _groupL5.text=[NSString stringWithFormat:@"%.2f",_frInfo.grouprank.OfflineScore];
    _groupL6.text=[NSString stringWithFormat:@"%.2f",_frInfo.grouprank.EvaluationScore];
    _groupL7.text=[NSString stringWithFormat:@"%.2f",_frInfo.grouprank.AllScore];
    _groupL8.text=[NSString stringWithFormat:@"%d",_frInfo.grouprank.MyRank];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
