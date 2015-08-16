//
//  FCourseDetailInfo.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "FCourseDetailInfo.h"

@implementation FCourseDetailInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.FCID = [dict[kFCID] longValue];
        self.Title = dict[kTitle];
        self.IsEnd = [dict[kIsEnd] boolValue];
        self.StartDate = dict[kStartDate];
        self.FCStudentCount = [dict[kFCStudentCount] intValue];
        self.FCLiveGroupCount = [dict[kFCLiveGroupCount] intValue];
        self.ClassNames = dict[kClassNames];
        self.Progress =dict[kProgress];
        self.OnlineProgress = [dict[kOnlineProgress] floatValue];
        self.TestProgress = [dict[kTestProgress] floatValue];
        self.TopicProgress = [dict[kTopicProgress] floatValue];
        self.StudentScoreProgress = [dict[kStudentScoreProgress] floatValue];
    }
    return self;
}

@end

