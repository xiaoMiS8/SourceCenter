//
//  HomeListCell.h
//  CourseCenter
//
//  Created by renxiaojian on 15/5/26.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCourseInfo.h"
#import "HomeViewController.h"
@interface HomeListCell : UITableViewCell
@property(nonatomic,strong)OCourseInfo *oCourse;
@property(nonatomic,strong)HomeViewController *hVC;
@end
