//
//  AffairInfo.m
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "AffairInfo.h"

@implementation AffairInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.AffairID = [dict[kAffairID] longValue];
        self.AffairType = [dict[kAffairType] intValue];
        self.AffairDesc = dict[kAffairDesc];
        self.CreateDate = dict[kCreateDate];
        self.UserID = [dict[KUserID] longValue];
        self.UserName = dict[KUserName];
        self.OrganizationName = dict[kOrganizationName];
        self.ClassName = dict[kClassName];
        self.Reson = dict[kReson];
        self.Status = [dict[kStatus] intValue];
    }
    return self;
}

@end

