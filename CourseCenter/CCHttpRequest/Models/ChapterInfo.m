//
//  ChapterInfo.m
//  
//
//  Created by jian on 15/6/23.
//
//

#import "ChapterInfo.h"

@implementation ChapterInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.ChapterID = [[dict objectForKey:kChapterID] longValue];
        self.TestID = [[dict objectForKey:kTestID] longValue];
        self.Title = [dict objectForKey:kTitle];
        self.ParentID = [[dict objectForKey:kParentID] longValue];
        self.Orde = [[dict objectForKey:kOrde] intValue];
        self.Brief = [dict objectForKey:kBrief];
        self.PlanDay = [[dict objectForKey:kPlanDay] longValue];
        self.MinHour = [[dict objectForKey:kMinHour] longValue];
        self.BuildMode = [[dict objectForKey:kBuildMode] intValue];
        self.FileNum = [[dict objectForKey:kFileNum] intValue];
        self.IsFinish = [[dict objectForKey:kIsFinish] boolValue];
        self.IsAllowStudy = [[dict objectForKey:kIsAllowStudy] integerValue];
        self.IsTest = [[dict objectForKey:kIsTest] boolValue];
        self.ChapterRate = [[dict objectForKey:kChapterRate] intValue];
    }
    return self;
}

@end

