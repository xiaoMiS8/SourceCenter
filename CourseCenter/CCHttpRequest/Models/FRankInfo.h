//
//  FRankInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RankInfo.h"

#define kgrouprank          @"grouprank"
#define kmyrank             @"myrank"
@interface FRankInfo : NSObject

    ///小组的成绩排名
@property(nonatomic, strong) RankInfo *grouprank;
    ///我的成绩排名
@property(nonatomic, strong) RankInfo *myrank;

- (id)initWithDict:(NSDictionary *)dict;

@end
