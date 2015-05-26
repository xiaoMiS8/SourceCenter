//
//  HomeListCell.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/26.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "HomeListCell.h"

@interface HomeListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgimg;
@property (weak, nonatomic) IBOutlet UIImageView *topbgImg;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *collegeLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation HomeListCell

- (void)awakeFromNib {
    self.bgView.layer.borderColor = [UIColor blackColor].CGColor;
    self.bgView.layer.borderWidth = 0.5;
    self.iconImg.layer.cornerRadius = 28;
    self.iconImg.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
