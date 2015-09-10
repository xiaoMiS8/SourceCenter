//
//  NoticeInfo.m
//  CourseCenter
//
//  Created by jian on 15/6/26.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "NoticeInfo.h"

@implementation NoticeInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.NoticeID = [[dict objectForKey:kNoticeID] longValue];
        self.UserID = [[dict objectForKey:kUserID] longValue];
        self.UserName = [dict objectForKey:kUserName];
        self.UserImg = [dict objectForKey:kKUserImg];
        self.Title = [dict objectForKey:kTitle];
        self.Conten = [dict objectForKey:kConten];
        self.UpdateTime = [dict objectForKey:kUpdateTime];
        self.ModuleID = [[dict objectForKey:kModuleID] longValue];
        self.IsTop  = [[dict objectForKey:kIsTop] boolValue];
        self.EndDate = [dict objectForKey:kEndDate];
        self.LastUser = [dict objectForKey:kLastUser];
        self.LastResponseTime = [dict objectForKey:kLastResponseTime];
        self.ResponseCount = [[dict objectForKey:kResponseCount] intValue];
        self.IsCanDel = [[dict objectForKey:kIsCanDel] boolValue];
        self.rowscount = [[dict objectForKey:krowscount] intValue];
        self.Gender = [dict[KGender] intValue];
        NSMutableArray *noticeResones = [[NSMutableArray alloc] initWithCapacity:0];
        id noticeResponse = [dict objectForKey:kNoticeResponse];
        if ([noticeResponse isKindOfClass:[NSArray class]]) {
            noticeResponse = (NSArray *)noticeResponse;
            for (int i=0; i<[noticeResponse count]; i++) {
                NoticeResponseInfo *notiresInfo = [[NoticeResponseInfo alloc] initWithDict:noticeResponse[i]];
                [noticeResones addObject:notiresInfo];
                
            }
            self.NoticeResponse = noticeResones;
        }
        self.imgs = dict[kNimgs];
        
    }
    
    return self;
}

@end

