//
//  NoticeResponseInfo.m
//  CourseCenter
//
//  Created by jian on 15/6/26.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "NoticeResponseInfo.h"

@implementation NoticeResponseInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.ResponseID = [[dict objectForKey:kResponseID] longValue];
        self.NoticeID = [[dict objectForKey:kNoticeID] longValue];
        self.UserID = [[dict objectForKey:kUserID] longValue];
        self.UserName = [dict objectForKey:kUserName];
        self.Conten = [dict objectForKey:kConten];
        self.UpdateTime = [dict objectForKey:kUpdateTime];
        self.ClassName = [dict objectForKey:kClassName];
        self.IsTop = [[dict objectForKey:kIsTop] boolValue];
        self.CurrentTime = [dict objectForKey:kCurrentTime];
        self.ResponseTimeStr = [dict objectForKey:kResponseTimeStr];
        
    }
    return self;
}

@end


