//
//  MessageCenterCell.m
//  CourseCenter
//
//  Created by 2345 on 15/7/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MessageCenterCell.h"
#import "UIImageView+WebCache.h"
#define HEADIMG @"iconpro"
@implementation MessageCenterCell

- (void)awakeFromNib {
    // Initialization code
    self.number.layer.masksToBounds=YES;
    self.number.layer.cornerRadius=7.5;
}
-(void)setMsgInfo:(MsgInfo *)msgInfo
{
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:msgInfo.UserImgUrl] placeholderImage:[UIImage imageNamed:HEADIMG]];
    if (_msgInfo==nil) {
        _msgInfo=msgInfo;
    }
    if (msgInfo.UnReadCount==0) {
        _number.hidden=YES;
    }else
    {
        _number.hidden=NO;
      _number.text=[NSString stringWithFormat:@"%d",msgInfo.UnReadCount];
    }
    _name.text=msgInfo.UserName;
    _message.text=msgInfo.Conten;
    _time.text=msgInfo.CreateTime;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
