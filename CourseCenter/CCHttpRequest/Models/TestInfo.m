//
//  TestInfo.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "TestInfo.h"

@implementation TestInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.FCLiveID = [dict[kFCLiveID] longValue];
        self.TestID = [dict[kTestID] longValue];
        self.Name = dict[kName];
        self.EndDate = dict[kEndDate];
        self.ExerciseCount = [dict[kExerciseCount] intValue];
        self.PaperID = [dict[kPaperID] longValue];
        self.Type = [dict[kType] intValue];
        self.LiveType = dict[kLiveType];
        self.BuildMode = [dict[kBuildMode] intValue];
        self.FastScore = [dict[kFastScore] intValue];
        self.UncommittedCount = [dict[kUncommittedCount] intValue];
        self.submittedCount = [dict[ksubmittedCount] intValue];
        self.MarkingCount = [dict[kMarkingCount] intValue];
    }
    return self;
}

@end
