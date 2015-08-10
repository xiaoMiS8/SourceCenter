//
//  RecruitInfo.m
//  CourseCenter
//
//  Created by jian on 15/7/30.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "RecruitInfo.h"

@implementation RecruitInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.RecruitID = [dict[kRecruitID] longValue];
        self.InReadStudentNum = [dict[kInReadStudentNum] intValue];
        self.UserLimit = [dict[kUserLimit] intValue];
        self.ClassName = dict[kClassName];
    }
    return self;
}

@end
