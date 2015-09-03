//
//  HomeListCell.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/26.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "HomeListCell.h"
#import "UIImageView+WebCache.h"
#import "HomeDetailViewController.h"
#import "ApplyViewController.h"
#import "TutorialViewController.h"
#import "CCHttpManager.h"
#import "LoginViewController.h"
#import "CourseTabbarViewController.h"
#import "TutorialViewController.h"
#import "FCourseViewController.h"
#import "BBsViewController.h"
#import "HWorkViewController.h"
#import "TPViewController.h"
#import "LineNavigationController.h"
#import "ReadViewController.h"
#import "UIImageView+WebCache.h"
#import "MyCourseListCell.h"

#define ICONIMG @"iconpro"
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
-(void)setOCourse:(OCourseInfo *)oCourse
{
    if (_oCourse==nil) {
        _oCourse=oCourse;
    }
    [self.bgimg sd_setImageWithURL:[NSURL URLWithString:oCourse.CourseImgUrl] placeholderImage:[UIImage imageNamed:NOPIC]];
    if (_oCourse.Gender==2) {
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:oCourse.TeacherImgUrl] placeholderImage:[UIImage imageNamed:@"iconpro"]];
    }else
    {
        [self.iconImg sd_setImageWithURL:[NSURL URLWithString:oCourse.TeacherImgUrl] placeholderImage:[UIImage imageNamed:@"me"]];
    }
    [self.nameLabel setText:oCourse.TeacherName];
    [self.collegeLabel setText:oCourse.OrganizationName];
    if (oCourse.RegStatus==1) {
      [self.gotoBtn setBackgroundImage:[UIImage imageNamed:STUDY] forState:UIControlStateNormal];
    }else{
      [self.gotoBtn setBackgroundImage:[UIImage imageNamed:SINGUP] forState:UIControlStateNormal];
    }
    [self.courseDetailLabel setText:oCourse.Name];
    [self.studentCountLabel setText:[NSString stringWithFormat:@"%d",oCourse.StudentCount]];
    self.gotoBtn.tag=oCourse.OCID;
    if (oCourse.RegStatus==1) {
        self.gotoBtn.userInteractionEnabled=YES;
        [self.gotoBtn setBackgroundImage:[UIImage imageNamed:@"study"] forState:UIControlStateNormal];
        //去学习的标识
        self.gotoBtn.titleLabel.text=@" ";
    }else if (oCourse.RegStatus==2 ||oCourse.RegStatus==4) {
        self.gotoBtn.userInteractionEnabled=YES;
        [self.gotoBtn setBackgroundImage:[UIImage imageNamed:@"signUp"] forState:UIControlStateNormal];
    }else
    {
        self.gotoBtn.userInteractionEnabled=NO;
    }
}
- (IBAction)isStudyOrSign:(id)sender {
    UIButton *btn=sender;
    if (![btn.titleLabel.text isEqualToString:@" "]) {
        ApplyViewController *applyVc = [[ApplyViewController alloc]init];
        applyVc.block=^()
        {
            _hVC.isFanhui=@"YES";
        };
        applyVc.OCID=btn.tag;
        [((AppDelegate *)app).nav pushViewController:applyVc animated:YES];
        return;
    }
//    TutorialViewController *tutoriaVC = [[TutorialViewController alloc] init];
//    tutoriaVC.title=@"教程";
//    tutoriaVC.OCID=btn.tag;
    
//    HomeDetailViewController *homeDetailVc = [[HomeDetailViewController alloc]init];
//    homeDetailVc.OCID=btn.tag;
//    homeDetailVc.teacherImgUrl=_oCourse.TeacherImgUrl;
//    homeDetailVc.topImgUrl=_oCourse.CourseImgUrl;
//    homeDetailVc.RegStatus=_oCourse.RegStatus;
//    [((AppDelegate *)app).nav pushViewController:tutoriaVC animated:YES];
    
    [((AppDelegate *)app).nav pushViewController:[self setTabbar] animated:YES];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
   
}

- (CourseTabbarViewController *)setTabbar {
    CourseTabbarViewController *tabbar = [[CourseTabbarViewController alloc] init];
    TutorialViewController *tutoriaVC = [[TutorialViewController alloc] init];
    tutoriaVC.OCID=self.oCourse.OCID;
    tutoriaVC.PushBlock = ^(UIViewController *viewController) {
        [tabbar.navigationController pushViewController:viewController animated:YES];
    };
    FCourseViewController *fCourseVC = [[FCourseViewController alloc] init];
    fCourseVC.ocourse = self.oCourse;
    fCourseVC.PushBlock = ^(UIViewController *viewController) {
        [tabbar.navigationController pushViewController:viewController animated:YES];
    };
    BBsViewController *bbsVC = [[BBsViewController alloc] init];
    bbsVC.OCID = self.oCourse.OCID;
    bbsVC.TitleChageBlock = ^(NSString *title) {
        tabbar.title = title;
    };
    bbsVC.PushBlock = ^(UIViewController *viewController) {
        [tabbar.navigationController pushViewController:viewController animated:YES];
    };
    HWorkViewController *hworkVC = [[HWorkViewController alloc] init];
    hworkVC.OCID=self.oCourse.OCID;
    hworkVC.PushBlock = ^(UIViewController *viewController) {
        [tabbar.navigationController pushViewController:viewController animated:YES];
    };
    ReadViewController *readVC = [ReadViewController new];
    readVC.OCID = self.oCourse.OCID;
    
    
    TPViewController *tpVC = [[TPViewController alloc] init];
    tpVC.OCID=self.oCourse.OCID;
    tpVC.PushBlock = ^(UIViewController *viewController) {
        [tabbar.navigationController pushViewController:viewController animated:YES];
    };
    
    NSArray *viewControllers = nil;
    NSArray *titles = nil;
    NSArray *itemImages = nil;
    NSArray *itemSelectedImages = nil;
    
    NSString *role = [[NSUserDefaults standardUserDefaults]objectForKey:@"role"];
    if ([role isEqualToString:@"4"]) {
        viewControllers = @[tutoriaVC,bbsVC, hworkVC];
        titles = @[@"教程",@"论坛",@"作业"];
        itemImages = @[@"cTabbar1_n",@"cTabbar3_n",@"cTabbar4_n"];
        itemSelectedImages = @[@"cTabbar1_s",@"cTabbar3_s",@"cTabbar4_s"];
        
    } else {
            //        viewControllers = @[tutoriaVC,bbsVC, readVC, tpVC];
            //        titles = @[@"教程",@"论坛",@"批阅",@"事务处理"];
            //        itemImages = @[@"cTabbar1_n",@"cTabbar3_n",@"cTabbar4_n",@"cTabbar5_n"];
            //        itemSelectedImages = @[@"cTabbar1_s",@"cTabbar3_s",@"cTabbar4_s",@"cTabbar5_s"];
        viewControllers = @[tutoriaVC,bbsVC, tpVC];
        titles = @[@"教程",@"论坛",@"事务处理"];
        itemImages = @[@"cTabbar1_n",@"cTabbar3_n",@"cTabbar5_n"];
        itemSelectedImages = @[@"cTabbar1_s",@"cTabbar3_s",@"cTabbar5_s"];
    }
    
    [tabbar setViewcontrollers:viewControllers itemImages:itemImages itemselectedImages:itemSelectedImages titles:titles];
    return tabbar;
    
}


@end
