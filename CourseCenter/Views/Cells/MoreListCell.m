//
//  MoreListCell.m
//  CourseCenter
//
//  Created by 2345 on 15/7/10.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MoreListCell.h"

@implementation MoreListCell

- (void)awakeFromNib {
    // Initialization code
    
    _headImag.layer.masksToBounds=YES;
    _headImag.layer.cornerRadius=5;
    _messageNum.layer.masksToBounds=YES;
    _messageNum.layer.cornerRadius=5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
