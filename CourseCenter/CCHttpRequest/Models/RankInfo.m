//
//  RankInfo.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "RankInfo.h"

@implementation RankInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.FileScore= [dict[kFileScore] floatValue];
        self.TestScore = [dict[kTestScore] floatValue];
        self.ForumScore = [dict[kForumScore] floatValue];
        self.SigninScore = [dict[kSigninScore] floatValue];
        self.OfflineScore = [dict[kOfflineScore] floatValue];
        self.EvaluationScore = [dict[kEvaluationScore] floatValue];
        self.AllScore = [dict[kAllScore] floatValue];
        self.MyRank = [dict[kMyRank] intValue];
        self.GroupID = [dict[kGroupID] longValue];
        self.Name = dict[kName];
        self.Sort = [dict[kSort] intValue];
    }
    return self;
}

@end


