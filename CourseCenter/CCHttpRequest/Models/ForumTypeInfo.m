//
//  ForumTypeInfo.m
//  CourseCenter
//
//  Created by rxj on 15/7/30.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "ForumTypeInfo.h"

@implementation ForumTypeInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.ForumTypeID = [dict[kForumTypeID] longValue];
        self.OCID = [dict[kOCID] longValue];
        self.CourseID = [dict[kCourseID] longValue];
        self.Title = dict[kTitle];
        self.Orde = dict[kOrde];
        self.IsEssence = [dict[kIsEssence] boolValue];
        self.Brief = dict[kBrief];
        self.IsPublic = [dict[kIsPublic] boolValue];
        self.UserID  = [dict[kUserID] longValue];
        self.ClassName = dict[kClassName];
        self.CreateDate = dict[kCreateDate];
        self.IsSys = [dict[kIsSys] boolValue];
        self.Topics = [dict[kTopics] intValue];
    }
    return self;
}

@end

