//
//  QuestionItemInfo.m
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "QuestionItemInfo.h"

@implementation QuestionItemInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.QuestionItemID = [dict[kQuestionItemID] longValue];
        self.QuestionID = [dict[kQuestionID] longValue];
        self.Conten = dict[kConten];
        self.MaxScore = [dict[kMaxScore] intValue];
    }
    return self;
}

@end
