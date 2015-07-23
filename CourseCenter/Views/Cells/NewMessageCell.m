//
//  NewMessageCell.m
//  CourseCenter
//
//  Created by 2345 on 15/7/18.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NewMessageCell.h"

@implementation NewMessageCell

- (void)awakeFromNib {
    // Initialization code
    _cell_category.layer.masksToBounds=YES;
    _cell_category.layer.cornerRadius=5;
}
-(void)setIndexPath:(NSIndexPath *)indexPath
{
    if ([_selectAll isEqualToString:@"YES"]) {
        [_imgBtn setBackgroundImage:[UIImage imageNamed:@"btn_confirm_hover"] forState:UIControlStateNormal];
    }else
    {
        [_imgBtn setBackgroundImage:[UIImage imageNamed:@"btn_confirm"] forState:UIControlStateNormal];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
