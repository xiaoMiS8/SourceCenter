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
    }
    return self;
}

@end