//
//  MyInfoCell.m
//  CourseCenter
//
//  Created by 2345 on 15/7/12.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MyInfoCell.h"
#import "UIImageView+WebCache.h"
#define HEADIMG @"iconpro"
@implementation MyInfoCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            _textFiled.hidden=YES;
            _headImg.hidden=NO;
            _leftLable.text=@"头   像";
            [self.headImg sd_setImageWithURL:[NSURL URLWithString:self.userInfo.userImg] placeholderImage:[UIImage imageNamed:HEADIMG]];
            break;
        case 1:
            _leftLable.text=@"用户名";
            _textFiled.text=self.userInfo.userName;
            break;
        case 2:
            _leftLable.text=@"性   别";
            if(self.userInfo.gender!=0)
            {
             _textFiled.text=self.userInfo.gender==1?@"男":@"女";
            }
            break;
        case 3:
            _leftLable.text=@"所在地";
            break;
        case 4:
            _leftLable.text=@"我的签名";
            _textFiled.hidden=YES;
            _textView.hidden=NO;
            _line.hidden=YES;
        default:
            break;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
