//
//  HWorkCell.h
//  CourseCenter
//
//  Created by muzhenhua on 15/8/5.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestInfo.h"
@interface HWorkCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property (weak, nonatomic) IBOutlet UILabel *lable3;
@property (weak, nonatomic) IBOutlet UILabel *lable4;
@property (strong,nonatomic) TestInfo *info;
@property (assign,nonatomic)NSInteger segSelectNum;
@end
