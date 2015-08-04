//
//  MyCourseListCell.m
//  CourseCenter
//
//  Created by jian on 15/7/23.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "MyCourseListCell.h"
#import "ProgressView.h"
#import "UIImageView+WebCache.h"

@interface MyCourseListCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *ocoureImg;
@property (weak, nonatomic) IBOutlet UIView *bomView;
@property (weak, nonatomic) IBOutlet ProgressView *progressView1;
@property (weak, nonatomic) IBOutlet ProgressView *progressView2;
@property (weak, nonatomic) IBOutlet UIImageView *teachImg;
@property (weak, nonatomic) IBOutlet UILabel *teachName;
@property (weak, nonatomic) IBOutlet UILabel *orgName;
@property (weak, nonatomic) IBOutlet UILabel *LastStudyChapter;
@property (weak, nonatomic) IBOutlet UILabel *ocName;
@property (weak, nonatomic) IBOutlet UILabel *TeachingClassName;
@property (weak, nonatomic) IBOutlet UILabel *mooc;
@property (weak, nonatomic) IBOutlet UILabel *myPrgoress;
@property (weak, nonatomic) IBOutlet UILabel *groupProgress;
@property (weak, nonatomic) IBOutlet UILabel *normProgress;
@property (weak, nonatomic) IBOutlet UILabel *fOcName;
@property (weak, nonatomic) IBOutlet UILabel *fmyProgress;
@property (weak, nonatomic) IBOutlet UILabel *fgroupProgress;
@property (weak, nonatomic) IBOutlet UILabel *fnormProgress;
@property (weak, nonatomic) IBOutlet UILabel *line;
@property (weak, nonatomic) IBOutlet UILabel *StudentCount;
@property (weak, nonatomic) IBOutlet UIImageView *userType;
@property (weak, nonatomic) IBOutlet UILabel *usertypeDes;


@end

@implementation MyCourseListCell

- (void)awakeFromNib {
    self.bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bgView.layer.borderWidth = 0.5f;
    self.bomView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bomView.layer.borderWidth = 0.5f;
    
}

- (void)setOCourse:(OCourseInfo *)oCourse {
    _oCourse = oCourse;
    [self.teachImg sd_setImageWithURL:[NSURL URLWithString:oCourse.TeacherImgUrl]];
    self.teachName.text = oCourse.TeacherName;
    self.orgName.text = oCourse.OrganizationName;
    self.ocName.text = oCourse.Name;
    self.TeachingClassName.text = oCourse.TeachingClassName;
    self.LastStudyChapter.text = oCourse.LastStudyChapter;
    self.StudentCount.text = [NSString stringWithFormat:@"%d",oCourse.StudentCount];
    [self.ocoureImg sd_setImageWithURL:[NSURL URLWithString:oCourse.CourseImgUrl]];
    if (!oCourse.IsShowMooc && !oCourse.IsShowFC) {
        for (NSLayoutConstraint *constraint in self.bomView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 0;
            }
        }
        self.line.hidden = YES;
        self.progressView1.hidden = YES;
        self.progressView2.hidden = YES;
        self.mooc.text = @"";
        self.myPrgoress.text = @"";
        self.groupProgress.text = @"";
        self.normProgress.text = @"";
        self.fmyProgress.text = @"";
        self.fgroupProgress.text = @"";
        self.fnormProgress.text = @"";
        self.fOcName.text = @"";
    } else if (!oCourse.IsShowFC && oCourse.IsShowMooc) {
        for (NSLayoutConstraint *constraint in self.bomView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 90;
            }
        }
        self.line.hidden = NO;
        self.progressView1.hidden = NO;
        self.progressView2.hidden = YES;
        self.mooc.text = @"MOOC";
        self.myPrgoress.text = [NSString stringWithFormat:@"我的进度%.1f%%",[oCourse.MyMoocRate floatValue]];
        self.groupProgress.text = @"";
        self.normProgress.text = [NSString stringWithFormat:@"标准进度%.1f%%",[oCourse.PlanMoocRate floatValue]];
        self.progressView1.myProgress = [oCourse.MyMoocRate floatValue]/100;
        self.progressView1.normProgress = [oCourse.PlanMoocRate floatValue]/100;
        self.progressView1.groupProgress = 0;
        self.fmyProgress.text = @"";
        self.fgroupProgress.text = @"";
        self.fnormProgress.text = @"";
        self.fOcName.text = @"";
    } else if (oCourse.IsShowFC && !oCourse.IsShowMooc) {
        for (NSLayoutConstraint *constraint in self.bomView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 90;
            }
        }
        self.line.hidden = NO;
        self.progressView1.hidden = YES;
        self.progressView2.hidden = NO;
        self.mooc.text = @"";
        self.progressView2.myProgress = [oCourse.MyFCRate floatValue]/100;
        self.progressView2.normProgress = [oCourse.PlanFCRate floatValue]/100;
        self.progressView2.groupProgress = [oCourse.MyGroupFCRate floatValue]/100;
        self.fmyProgress.text = [NSString stringWithFormat:@"我的进度%.1f",[oCourse.MyFCRate floatValue]];
        self.fgroupProgress.text = [NSString stringWithFormat:@"我的小组进度%.1f",[oCourse.MyGroupFCRate floatValue]];
        self.fnormProgress.text = [NSString stringWithFormat:@"标准进度%.1f",[oCourse.PlanFCRate floatValue]];
        self.fOcName.text = @"翻转课堂";
        
    }else {
        for (NSLayoutConstraint *constraint in self.bomView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 180;
            }
        }
        self.line.hidden = NO;
        self.progressView1.hidden = NO;
        self.progressView2.hidden = NO;
        self.mooc.text = @"MOOC";
        self.myPrgoress.text = [NSString stringWithFormat:@"我的进度%.1f",[oCourse.MyMoocRate floatValue]];
        self.groupProgress.text = @"";
        self.normProgress.text = [NSString stringWithFormat:@"标准进度%.1f",[oCourse.PlanMoocRate floatValue]];
        self.progressView1.myProgress = [oCourse.MyMoocRate floatValue]/100;
        self.progressView1.normProgress = [oCourse.PlanMoocRate floatValue]/100;
        self.progressView1.groupProgress = 0;
        self.progressView2.myProgress = [oCourse.MyFCRate floatValue]/100;
        self.progressView2.normProgress = [oCourse.PlanFCRate floatValue]/100;
        self.progressView2.groupProgress = [oCourse.MyGroupFCRate floatValue]/100;
        self.fmyProgress.text = [NSString stringWithFormat:@"我的进度%.1f",[oCourse.MyFCRate floatValue]];
        self.fgroupProgress.text = [NSString stringWithFormat:@"我的小组进度%.1f",[oCourse.MyGroupFCRate floatValue]];
        self.fnormProgress.text = [NSString stringWithFormat:@"标准进度%.1f",[oCourse.PlanFCRate floatValue]];
        self.fOcName.text = @"翻转课堂";
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  
}


@end
