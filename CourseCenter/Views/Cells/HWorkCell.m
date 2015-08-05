//
//  HWorkCell.m
//  CourseCenter
//
//  Created by muzhenhua on 15/8/5.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "HWorkCell.h"

@implementation HWorkCell

- (void)awakeFromNib {
    // Initialization code
    _lable2.layer.borderWidth=1;
    _lable2.layer.masksToBounds=YES;
    _lable2.layer.cornerRadius=3;
    _lable2.textColor=[UIColor orangeColor];
    _lable2.layer.borderColor=[UIColor orangeColor].CGColor;
}
-(void)setInfo:(TestInfo *)info
{
    if (_info!=info) {
        _info=info;
    }
    _lable1.text=_info.Name;
    _lable2.text=_info.LiveType;
    _lable3.text=_info.EndDate;
    if (_segSelectNum==1) {
    _lable4.text=_info.FastScore;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
