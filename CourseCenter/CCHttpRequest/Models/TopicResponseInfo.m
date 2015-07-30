//
//  TopicResponseInfo.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/29.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "TopicResponseInfo.h"

@implementation TopicResponseInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.ResponseID = [dict[kResponseID] longValue];
        self.ParentID = [dict[kParentID] longValue];
        self.Conten = dict[kConten];
        self.UserName = dict[kUserName];
        self.FromClassName = dict[kForumClassName];
        self.UpdateTime = dict[kUpdateTime];
        self.IsTop = [dict[kIsTop] boolValue];
        self.IsGood = [dict[kIsGood] boolValue];
        self.Goods = [dict[kGoods] longValue];
    }
    return self;
}

@end
