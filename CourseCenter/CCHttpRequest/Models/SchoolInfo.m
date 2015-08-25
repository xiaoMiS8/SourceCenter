//
//  SchoolInfo.m
//  CourseCenter
//
//  Created by 2345 on 15/8/25.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "SchoolInfo.h"

@implementation SchoolInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.Schoolname = dict[kSchoolname];
        self.Url = dict[kUUrl];
        self.Jwd = dict[kJwd];
    }
    return self;
}

@end
