//
//  FCourseCell.h
//  CourseCenter
//
//  Created by 2345 on 15/8/2.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCourseInfo.h"
@interface FCourseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property (weak, nonatomic) IBOutlet UILabel *lable3;
@property (weak, nonatomic) IBOutlet UILabel *lable4;
@property (weak, nonatomic) IBOutlet UILabel *lable5;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *lable6;
@property (nonatomic,strong)FCourseInfo *info;
@end
