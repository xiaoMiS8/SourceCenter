//
//  TestUserNotCheckInfo.m
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "TestUserNotCheckInfo.h"

@implementation TestUserNotCheckInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.TestID = [dict[kTestID] longValue];
        self.TestName = dict[kTestName];
        self.SubmitTime = dict[kSubmitTime];
        self.UserID = [dict[kUserID] longValue];
        self.UserNo = dict[kUserNo];
        self.UserName = dict[kUserName];
        self.SpecialtyName = dict[kSpecialtyName];
        self.BuildMode = [dict[kBuildMode] intValue];
    }
    return self;
}

@end
