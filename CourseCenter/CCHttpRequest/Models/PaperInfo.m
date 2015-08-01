//
//  PaperInfo.m
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "PaperInfo.h"

@implementation PaperInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.PaperID = [dict[KPaperID] longValue];
        self.CourseID = [dict[kCourseID] longValue];
        self.OCID = [dict[kOCID] longValue];
        self.OwnerUserID = [dict[kOwnerUserID] longValue];
        self.CreateUserID = [dict[kCreateUserID] longValue];
        self.UserName = dict[kUserName];
        self.Papername = dict[kPapername];
        self.Type = [dict[kType] intValue];
        self.Scope = [dict[kScope] intValue];
        self.ShareScope = [dict[kShareScope] intValue];
        self.TimeLimit = [dict[kTimeLimit] intValue];
        self.Brief = dict[kBrief];
        self.UpdateTime = dict[kUpdateTime];
        self.Num = [dict[kNum] intValue];
        self.Score = [dict[kScore] intValue];
        self.Conten = dict[kConten];
        self.Answer = dict[kAnswer];
    }
    return self;
}

@end

