//
//  FCourseDetailInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCourseInfo.h"

#define kOnlineProgress             @"OnlineProgress"
#define kTestProgress               @"TestProgress"
#define kTopicProgress              @"TopicProgress"
#define kStudentScoreProgress       @"StudentScoreProgress"

@interface FCourseDetailInfo : FCourseInfo

    ///线上内容总进度
@property(nonatomic, assign) float OnlineProgress;
    ///作业完成度
@property(nonatomic, assign) float TestProgress;
    ///讨论进度
@property(nonatomic, assign) float TopicProgress;
    ///学生评分总进度
@property(nonatomic, assign) float StudentScoreProgress;

- (id)initWithDict:(NSDictionary *)dict;

@end

