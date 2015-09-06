//
//  TpHistoryCell.m
//  CourseCenter
//
//  Created by muzhenhua on 15/8/5.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "TpHistoryCell.h"

@implementation TpHistoryCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setInfo:(AffairInfo *)info
{
    if (_info!=info) {
        _info=info;
    }
    _label1.text=_info.AffairType;
    _label2.text=_info.CreateDate;
    _label3.text=_info.UserName;
    _label4.text=_info.ClassName;
    _label5.text=_info.AffairDesc;
    if (_info.Status==1) {
        _label6.text=@"拒绝";
    }else if(_info.Status==2)
    {
        _label6.text=@"同意";
    }else
    {
        _label6.text=@"未审核";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
