//
//  SurveyAnswerInfo.m
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "SurveyAnswerInfo.h"

@implementation SurveyAnswerInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.survey = [[SurveyInfo alloc] initWithDict:dict[ksurvey]];
        NSArray *array = dict[kquestion];
        NSMutableArray *questions = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i=0; i<array.count; i++) {
            QuestionInfo *question = [[QuestionInfo alloc] initWithDict:array[i]];
            [questions addObject:question];
            
        }
        self.question = questions;
        NSArray *items = dict[kquestionitem];
        NSMutableArray *questItems = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i=0; i<items.count; i++) {
            QuestionItemInfo *item = [[QuestionItemInfo alloc] initWithDict:items[i]];
            [questItems addObject:item];
        }
        self.questionitem = questItems;
        NSArray *ansta = dict[kanswersta];
        NSMutableArray *answertas = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i=0; i<ansta.count; i++) {
            AnswerInfo *answer = [[AnswerInfo alloc] initWithDict:ansta[i]];
            [answertas addObject:answer];
        }
        NSArray *ansgets = dict[kanswerget];
        NSMutableArray *answergets = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i=0; i<ansgets.count; i++) {
            AnswerInfo *answer = [[AnswerInfo alloc] initWithDict:ansgets[i]];
            [answergets addObject:answer];
        }
        self.answersta = answertas;
        self.answerget = answergets;
    }
    return self;
}

@end
