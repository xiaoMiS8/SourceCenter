//
//  QuestionSurveyCell.h
//  CourseCenter
//
//  Created by 2345 on 15/8/7.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurveyInfo.h"
@interface QuestionSurveyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (strong,nonatomic)SurveyInfo *info;
@end
