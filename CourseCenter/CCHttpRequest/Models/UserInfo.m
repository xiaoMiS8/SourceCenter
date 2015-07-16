//
//  UserInfo.m
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (id)initDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.userID = [[dict objectForKey:KUserID] longValue];
        self.userType = [[dict objectForKey:KUserType] intValue];
        self.userName = [dict objectForKey:KUserName];
        self.userNo = [dict objectForKey:KUserNo];
        self.userImg = [dict objectForKey:KUserImg];
        self.gender = [[dict objectForKey:KGender] intValue];
        self.Role = dict[kRole];
    }
    return self;
}

@end
