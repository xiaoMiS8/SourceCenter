//
//  MyCourseListCell.m
//  CourseCenter
//
//  Created by jian on 15/7/23.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "MyCourseListCell.h"

@interface MyCourseListCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *bomView;

@end

@implementation MyCourseListCell

- (void)awakeFromNib {
    self.bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bgView.layer.borderWidth = 0.5f;
    self.bomView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bomView.layer.borderWidth = 0.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  
}

@end
