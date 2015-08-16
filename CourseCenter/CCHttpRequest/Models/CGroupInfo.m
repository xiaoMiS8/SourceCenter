//
//  CGroupInfo.m
//  CourseCenter
//
//  Created by jian on 15/7/27.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "CGroupInfo.h"

@implementation CGroupInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.GroupID = [dict[kGroupID] longValue];
        self.Name = dict[kName];
        self.UserCount = [dict[kUserCount] intValue];
        self.RanKInfo = dict[kRanKInfo];
        self.GroupCount = [dict[kGroupCount] intValue];
        self.GroupProgress = [dict[kGroupProgress] floatValue];
    }
    return self;
}

@end

