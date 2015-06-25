//
//  CourseDetailCell.m
//  CourseCenter
//
//  Created by Mac on 15-6-24.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "CourseDetailCell.h"

@implementation CourseDetailCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.layer.borderColor=RGBA(205, 205, 205, 1).CGColor;
    self.contentView.layer.borderWidth=0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
