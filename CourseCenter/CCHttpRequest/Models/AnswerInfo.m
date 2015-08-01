//
//  AnswerInfo.m
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "AnswerInfo.h"

@implementation AnswerInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.AnswerID = [dict[kAnswerID] longValue];
        self.SurveyID = [dict[kSurveyID] longValue];
        self.QuestionID = [dict[kQuestionID] longValue];
        self.UserID = [dict[KUserID] longValue];
        self.Conten = dict[kConten];
        self.QuestionItemID = [dict[kQuestionItemID] longValue];
        self.Score = [dict[kScore] intValue];
        self.ObjectID = [dict[kObjectID] longValue];
        self.SelectCount = [dict[kSelectCount] intValue];
    }
    return self;
}

@end

