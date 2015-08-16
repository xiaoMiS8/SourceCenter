//
//  surveyDetailInfo.m
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "surveyDetailInfo.h"

@implementation surveyDetailInfo

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
    }
    return self;
}

@end
