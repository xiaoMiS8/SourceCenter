//
//  HomeListCell.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/26.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "HomeListCell.h"
#import "UIImageView+WebCache.h"
#define ICONIMG @"iconpro"
#define BAGNIMG @"nav_bg"
#define STUDY   @"study"
#define SINGUP  @"SINGUP"
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
@property (weak, nonatomic) IBOutlet UIView *twoView;
@property (weak, nonatomic) IBOutlet UIButton *gotoBtn;

@end

@implementation HomeListCell

- (void)awakeFromNib {
    self.bgView.layer.borderColor = [UIColor blackColor].CGColor;
    self.bgView.layer.borderWidth = 0.5;
    self.iconImg.layer.cornerRadius = 28;
    self.iconImg.layer.masksToBounds = YES;
    self.gotoBtn.layer.cornerRadius = 14;
    self.gotoBtn.layer.masksToBounds = YES;
    
}
-(void)setOCourse:(OCourse *)oCourse
{
    [self.bgimg sd_setImageWithURL:[NSURL URLWithString:oCourse.CourseImgUrl] placeholderImage:[UIImage imageNamed:BAGNIMG]];
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:oCourse.TeacherImgUrl] placeholderImage:[UIImage imageNamed:ICONIMG]];
    [self.nameLabel setText:oCourse.TeacherName];
    [self.collegeLabel setText:oCourse.OrganizationName];
    if (oCourse.RegStatus==1) {
      [self.gotoBtn setBackgroundImage:[UIImage imageNamed:STUDY] forState:UIControlStateNormal];
    }else{
      [self.gotoBtn setBackgroundImage:[UIImage imageNamed:SINGUP] forState:UIControlStateNormal];
    }
    [self.courseDetailLabel setText:oCourse.Name];
    [self.studentCountLabel setText:[NSString stringWithFormat:@"%d",oCourse.StudentCount]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
   
}

@end
