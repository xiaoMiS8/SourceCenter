//
//  RankInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFileScore              @"FileScore"
#define kTestScore              @"TestScore"
#define kForumScore             @"ForumScore"
#define kSigninScore            @"SigninScore"
#define kOfflineScore           @"OfflineScore"
#define kEvaluationScore        @"EvaluationScore"
#define kAllScore               @"AllScore"
#define kMyRank                 @"MyRank"
#define kGroupID                @"GroupID"
#define kName                   @"Name"
#define kSort                   @"Sort"

@interface RankInfo : NSObject

    ///学习资料
@property(nonatomic, assign) float FileScore;
    ///作业测试
@property(nonatomic, assign) float TestScore;
    ///论坛互动
@property(nonatomic, assign) float ForumScore;
    ///课堂签到
@property(nonatomic, assign) float SigninScore;
    ///线下成绩
@property(nonatomic, assign) float OfflineScore;
    ///互相评价
@property(nonatomic, assign) float EvaluationScore;
    ///总成绩
@property(nonatomic, assign) float AllScore;
    ///总排名
@property(nonatomic, assign) int MyRank;
    //小组ID
@property(nonatomic, assign) long GroupID;
    //组名
@property(nonatomic, strong) NSString *Name;
    //排名
@property(nonatomic, assign) int Sort;

- (id)initWithDict:(NSDictionary *)dict;

@end


