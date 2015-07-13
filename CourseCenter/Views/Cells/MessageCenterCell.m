//
//  MessageCenterCell.m
//  CourseCenter
//
//  Created by 2345 on 15/7/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MessageCenterCell.h"

@implementation MessageCenterCell

- (void)awakeFromNib {
    // Initialization code
    self.number.layer.masksToBounds=YES;
    self.number.layer.cornerRadius=7.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
