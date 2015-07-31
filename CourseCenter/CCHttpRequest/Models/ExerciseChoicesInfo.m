//
//  ExerciseChoicesInfo.m
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "ExerciseChoicesInfo.h"

@implementation ExerciseChoicesInfo

- (id)initWithDict:(NSDictionary *)dict {
    self =  [super init];
    if (self) {
        self.ChoiceID = [dict[kChapterID] longValue];
        self.ExerciseID = [dict[kExerciseID] longValue];
        self.Conten = dict[kConten];
        self.IsCorrect = [dict[kIsCorrect] boolValue];
        self.Grou = dict[kGrou];
        self.OrderNum = [dict[kOrderNum] intValue];
    }
    return self;
}

@end

