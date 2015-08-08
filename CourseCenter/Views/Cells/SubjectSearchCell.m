//
//  SubjectSearchCell.m
//  CourseCenter
//
//  Created by 2345 on 15/6/30.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "SubjectSearchCell.h"
#import "UIImageView+WebCache.h"
#define ICONIMG @"iconpro"
#define STUDY   @"study"
#define SINGUP  @"SINGUP"
@interface SubjectSearchCell()
@property (weak, nonatomic) IBOutlet UIImageView *subjectImg;
@property (weak, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentCountLabel;

@end
@implementation SubjectSearchCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setOCourse:(OCourseInfo *)oCourse
{
    [self.subjectImg sd_setImageWithURL:[NSURL URLWithString:oCourse.CourseImgUrl] placeholderImage:[UIImage imageNamed:NOPIC]];
    [self.nameLabel setText:oCourse.TeacherName];
    [self.subjectLabel setText:oCourse.Name];
    [self.studentCountLabel setText:[NSString stringWithFormat:@"%d个同学",oCourse.StudentCount]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
