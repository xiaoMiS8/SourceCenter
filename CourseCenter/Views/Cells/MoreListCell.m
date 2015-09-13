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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateUserImg:) name:@"UploadSuccess" object:nil];
}
-(void)setUserInfo:(UserInfo *)userInfo
{
    _userInfo = userInfo;
}
-(void)setIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if (self.userInfo.gender==2) {
              [self.headImag sd_setImageWithURL:[NSURL URLWithString:self.userInfo.userImg] placeholderImage:[UIImage imageNamed:@"iconpro"]];
            }else
            {
             [self.headImag sd_setImageWithURL:[NSURL URLWithString:self.userInfo.userImg] placeholderImage:[UIImage imageNamed:@"me"]];
            }
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
//        case 0:
//            _headImag.image=[UIImage imageNamed:@"icon_vote"];
//            _headName.text=@"教学投票";
//            break;
        case 0:
            _headImag.image=[UIImage imageNamed:@"icon_datum"];
            _headName.text=@"学习资料";
            break;
        case 1:
            _headImag.image=[UIImage imageNamed:@"icon_download"];
            _headName.text=@"我的下载";
            break;
//        case 3:
//            _headImag.image=[UIImage imageNamed:@"icon_calendar"];
//            _headName.text=@"我的日程";
//            break;
        default:
            break;
    }
    
}

-(void)updateUserImg:(NSNotification *)not
{
    NSIndexPath* indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    self.userInfo.userImg=not.object;
    [self setIndexPath:indexPath];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
