//
//  TopicInfo.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/29.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "TopicInfo.h"

@implementation TopicInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.TopicID = [dict[kTopicID] longValue];
        self.IsEssence = [dict[kIsEssence] boolValue];
        self.IsTop = [dict[kIsTop] boolValue];
        self.Title = dict[kTitle];
        self.Conten = dict[kConten];
        self.UserName = dict[kUserName];
        self.IsTeacherTopic = [dict[kIsTeacherTopic] boolValue];
        self.ForumClassName = dict[kForumClassName];
        self.UpdateTime = dict[kUpdateTime];
        self.Clicks = [dict[kClicks] longValue];
        self.Responses = [dict[kResponses] longValue];
        self.Goods = [dict[kGoods] longValue];
        self.IsGood = [dict[kIsGood] boolValue];
        self.RowsCount = [dict[kRowsCount] longValue];
        self.iscanDel = [dict[kIsCanDel] boolValue];
        self.Gender = [dict[KGender] intValue];
    }
    return self;
}

@end

