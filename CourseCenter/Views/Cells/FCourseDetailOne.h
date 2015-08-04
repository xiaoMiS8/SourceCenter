//
//  FCourseDetailOne.h
//  CourseCenter
//
//  Created by muzhenhua on 15/8/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGroupInfo.h"
@interface FCourseDetailOne : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *groupName;
@property (weak, nonatomic) IBOutlet UILabel *groupRank;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *progressNumber;
@property (strong,nonatomic)CGroupInfo *cgInfo;
@end
