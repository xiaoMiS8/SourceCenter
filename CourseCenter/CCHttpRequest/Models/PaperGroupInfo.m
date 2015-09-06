//
//  PaperGroupInfo.m
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "PaperGroupInfo.h"

@implementation PaperGroupInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.GroupID = [dict[kGroupID] longValue];
        self.PaperID = [dict[kPaperID] longValue];
        self.GroupName = dict[kGroupName];
        self.Orde = dict[kOrde];
        self.Brief =  dict[kBrief];
        self.Timelimit = [dict[kTimelimit] intValue];
    }
    return self;
}


@end

