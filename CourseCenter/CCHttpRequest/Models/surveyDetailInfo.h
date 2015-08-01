//
//  surveyDetailInfo.h
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SurveyInfo.h"
#import "QuestionInfo.h"
#import "QuestionItemInfo.h"

#define ksurvey                 @"survey"
#define kquestion               @"question"
#define kquestionitem           @"questionitem"

@interface surveyDetailInfo : NSObject

    ///基本信息
@property(nonatomic, strong) SurveyInfo *survey;
    ///题目
@property(nonatomic, strong) NSArray *question;
    ///选项
@property(nonatomic, strong) NSArray *questionitem;

- (id)initWithDict:(NSDictionary *)dict;

@end
