//
//  LiveForumInfo.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "LiveForumInfo.h"

@implementation LiveForumInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.FCID = [dict[kFCID] longValue];
        self.FCLiveID = [dict[kFCLiveID] longValue];
        self.TopicID = [dict[kTopicID] longValue];
        self.Title = dict[kTitle];
        self.Brief = dict[kBrief];
        self.Responses = [dict[kResponses] intValue];
        self.LastUserName = dict[kLastUserName];
    }
    return self;
}

@end
