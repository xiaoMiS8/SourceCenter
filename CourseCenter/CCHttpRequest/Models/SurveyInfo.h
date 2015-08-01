//
//  SurveyInfo.h
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSurveyID                   @"SurveyID"
#define kTitle                      @"Title"
#define kBrief                      @"Brief"
#define kStartDate                  @"StartDate"
#define kEndDate                    @"EndDate"
#define kSubmits                    @"Submits"
#define kAllCount                   @"AllCount"
#define kStatus                     @"Status"
#define kVoteStatus                 @"VoteStatus"

@interface SurveyInfo : NSObject

    ///问卷ID
@property(nonatomic, assign) long SurveyID;
    ///问卷标题
@property(nonatomic, strong) NSString *Title;
    ///内容
@property(nonatomic, strong) NSString *Brief;
    ///开始时间
@property(nonatomic, strong) NSString *StartDate;
    ///结束时间
@property(nonatomic, strong) NSString *EndDate;
    ///提交人数
@property(nonatomic, assign) int Submits;
    ///总人数
@property(nonatomic, assign) int AllCount;
    ///问卷状态（1未开始2进行中3暂停4完成)
@property(nonatomic, assign) int Status;
    ///提交状态（1未提交2已提交）
@property(nonatomic, assign) int VoteStatus;

- (id)initWithDict:(NSDictionary *)dict;

@end
