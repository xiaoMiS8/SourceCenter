//
//  SurveyInfo.m
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "SurveyInfo.h"

@implementation SurveyInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.SurveyID = [dict[kSurveyID] longValue];
        self.Title = dict[kTitle];
        self.Brief = dict[kBrief];
        self.StartDate = dict[kStartDate];
        self.EndDate = dict[kEndDate];
        self.Submits = [dict[kSubmits] intValue];
        self.AllCount = [dict[kAllCount] intValue];
        self.Status = [dict[kStatus] intValue];
        self.VoteStatus = [dict[kVoteStatus] intValue];
    }
    return self;
}

@end
