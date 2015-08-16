//
//  FCOfflineInfo.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "FCOfflineInfo.h"

@implementation FCOfflineInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.FCOfflineID = [dict[kFCOfflineID] longValue];
        self.FCID = [dict[kFCID] longValue];
        self.Title = dict[kTitle];
        self.StartTime = dict[kStartTime];
        self.EndTime = dict[kEndTime];
        self.Address = dict[kAddress];
    }
    return self;
}

@end
