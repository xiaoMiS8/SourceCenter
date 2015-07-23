//
//  MoreListCell.m
//  CourseCenter
//
//  Created by 2345 on 15/7/10.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MoreListCell.h"
#import "UIImageView+WebCache.h"
#define HeadIMG @"iconpro"
@implementation MoreListCell

- (void)awakeFromNib {
    // Initialization code
    _headImag.layer.masksToBounds=YES;
    _headImag.layer.cornerRadius=5;
    _messageNum.layer.masksToBounds=YES;
    _messageNum.layer.cornerRadius=5;

}
-(void)setUserInfo:(UserInfo *)userInfo
{
    _userInfo = userInfo;
}
-(void)setIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section!=0) {
        self.topLayoutConstraint.constant= 9;
    }
    switch (indexPath.section) {
        case 0:
            [self.headImag sd_setImageWithURL:[NSURL URLWithString:self.userInfo.userImg] placeholderImage:[UIImage imageNamed:HeadIMG]];
            _headName.text=self.userInfo.userName;
            break;
        case 1:
            _headImag.image=[UIImage imageNamed:@"icon_news"];
            _headName.text=@"消息中心";
            self.messageNum.hidden=NO;
            self.messageNum.text=[NSString stringWithFormat:@"%d",self.msgInfo.UnReadCount];
            break;
        case 2:
            [self setSectionWith:indexPath];
            break;
        case 3:
            _headImag.image=[UIImage imageNamed:@"icon_set"];
            _headName.text=@"设置";
            break;
        default:
            break;
    }
}
-(void)setSectionWith:(NSIndexPath *)myIndexPath
{
    switch (myIndexPath.row) {
        case 0:
            _headImag.image=[UIImage imageNamed:@"icon_vote"];
            _headName.text=@"教学投票";
            break;
        case 1:
            _headImag.image=[UIImage imageNamed:@"icon_download"];
            _headName.text=@"离线下载";
            break;
        case 2:
            _headImag.image=[UIImage imageNamed:@"icon_datum"];
            _headName.text=@"学习资料";
            break;
        case 3:
            _headImag.image=[UIImage imageNamed:@"icon_calendar"];
            _headName.text=@"我的日程";
            break;
        default:
            break;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
