//
//  ExerciseInfo.m
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "ExerciseInfo.h"

@implementation ExerciseInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.PaperExerciseID = [dict[kPaperExerciseID] longValue];
        self.PaperID = [dict[kPaperID] longValue];
        self.PaperGroupID = [dict[kPaperGroupID] longValue];
        self.ParentExerciseID = [dict[kParentExerciseID] longValue];
        self.PaperTacticID = [dict[kPaperTacticID] longValue];
        self.Conten = dict[kConten];
        self.Kens =  dict[kKens];
        self.Keys = dict[kKeys];
        self.Diffcult = [dict[kDiffcult] floatValue];
        self.IsRand = [dict[kIsRand] boolValue];
        self.ExerciseTypeName = dict[kExerciseTypeName];
        self.ExerciseType = [dict[kExerciseType] intValue];
        self.Score = [dict[kScore] intValue];
        self.Orde = dict[kOrde];
        self.Answer = dict[kAnswer];
    }
    return self;
}

@end


