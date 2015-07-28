//
//  FRankInfo.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "FRankInfo.h"

@implementation FRankInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.myrank = [[RankInfo alloc] initWithDict:dict[kMyRank]];
        self.grouprank = [[RankInfo alloc] initWithDict:dict[kgrouprank]];
    }
    return self;
}

@end
