//
//  ResourseInfo.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "SourceInfo.h"

@implementation SourceInfo

- (id)initWithdict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.SourceID = [dict[kSourceID] longValue];
        self.Title = dict[kTitle];
        self.IsFinish = [dict[kIsFinish] boolValue];
    }
    return self;
}

@end
