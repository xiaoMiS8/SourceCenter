//
//  MsgInfo.m
//  CourseCenter
//
//  Created by jian on 15/7/15.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "MsgInfo.h"

@implementation MsgInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.UnReadCount = [dict[kUnReadCount] intValue];
        self.UserImgUrl = dict[kUserImgUrl];
        self.Conten = dict[kConten];
        self.UserID = [dict[kUserID] longValue];
        self.UserName = dict[kUserName];
        self.CreateTime = dict[kCreateTime];
        self.SendOrReceive = dict[kSendOrReceive];
        self.Gender = [dict[KGender] intValue];
    }
    return self;
}

@end
