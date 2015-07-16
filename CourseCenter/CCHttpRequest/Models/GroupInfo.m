//
//  GroupInfo.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/16.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "GroupInfo.h"

@implementation GroupInfo

- (id)initWithDict:(NSDictionary *)dict {
    self =[super init];
    if (self) {
        self.ID = [dict[kID] integerValue];
        self.Name = dict[kName];
        self.Type = [dict[kType] intValue];
    }
    return self;
}

@end
