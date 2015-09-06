//
//  QuestionSurveyCell.m
//  CourseCenter
//
//  Created by 2345 on 15/8/7.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "QuestionSurveyCell.h"

@implementation QuestionSurveyCell

- (void)awakeFromNib {
    // Initialization code
    _label2.layer.masksToBounds=YES;
    _label2.layer.cornerRadius=3;
}
-(void)setInfo:(SurveyInfo *)info
{
    if (_info!=info) {
        _info=info;
    }
    _label1.text=info.Title;
    if (info.VoteStatus==1) {
      _label2.text=@"未投票";
      _label2.backgroundColor=[UIColor greenColor];
    }else
    {
      _label2.text=@"已投票";
      _label2.backgroundColor=[UIColor grayColor];
    }
    _label3.text=info.EndDate;
    _label4.text=[NSString stringWithFormat:@"%d/%d",info.Submits,info.AllCount];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
