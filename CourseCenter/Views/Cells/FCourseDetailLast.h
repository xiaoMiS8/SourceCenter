//
//  FCourseDetailLast.h
//  CourseCenter
//
//  Created by muzhenhua on 15/8/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRankInfo.h"
#import "CGroupInfo.h"
@interface FCourseDetailLast : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalG;
@property (weak, nonatomic) IBOutlet UILabel *totalP;
@property (weak, nonatomic) IBOutlet UILabel *myL1;
@property (weak, nonatomic) IBOutlet UILabel *myL2;
@property (weak, nonatomic) IBOutlet UILabel *myL3;
@property (weak, nonatomic) IBOutlet UILabel *myL4;
@property (weak, nonatomic) IBOutlet UILabel *myL5;
@property (weak, nonatomic) IBOutlet UILabel *myL6;
@property (weak, nonatomic) IBOutlet UILabel *myL7;
@property (weak, nonatomic) IBOutlet UILabel *myL8;
@property (weak, nonatomic) IBOutlet UILabel *groupL1;
@property (weak, nonatomic) IBOutlet UILabel *groupL2;
@property (weak, nonatomic) IBOutlet UILabel *groupL3;
@property (weak, nonatomic) IBOutlet UILabel *groupL4;
@property (weak, nonatomic) IBOutlet UILabel *groupL5;
@property (weak, nonatomic) IBOutlet UILabel *groupL6;
@property (weak, nonatomic) IBOutlet UILabel *groupL7;
@property (weak, nonatomic) IBOutlet UILabel *groupL8;
@property (strong,nonatomic) FRankInfo *frInfo;
@property (strong,nonatomic) CGroupInfo *cgInfo;
@end
