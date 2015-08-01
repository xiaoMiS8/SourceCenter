//
//  QuestionInfo.m
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "QuestionInfo.h"

@implementation QuestionInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.QuestionID = [dict[kQuestionID] longValue];
        self.SurveyID = [dict[kSurveyID] longValue];
        self.Type = [dict[kType] intValue];
        self.Conten = dict[kConten];
        self.IsMust = [dict[kIsMust] boolValue];
        self.IsRandom = [dict[kIsRandom] boolValue];
        self.MinSel = [dict[kMinSel] intValue];
        self.MaxSel = [dict[kMaxSel] intValue];
        self.ParentID = [dict[kParentID] longValue];
    }
    return self;
}

@end


