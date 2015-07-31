//
//  TestAnswerInfo.m
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "TestAnswerInfo.h"

@implementation TestAnswerInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.UserID = [dict[kUserID] longValue];
        self.CheckUserID = [dict[kCheckUserID] longValue];
        self.ExerciseID = [dict[kExerciseID] longValue];
        self.Conten = dict[kConten];
        self.Score = [dict[kScore] intValue];
        self.Comment = dict[kComment];
        self.ExerciseType = [dict[kExerciseType] intValue];
        self.ChoiceNum = [dict[kChoiceNum] intValue];
        self.PaperExerciseScore = [dict[kPaperExerciseScore] intValue];
    }
    return self;
}

@end

