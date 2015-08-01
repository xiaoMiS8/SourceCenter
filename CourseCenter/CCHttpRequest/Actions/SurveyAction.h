//
//  SurveyAction.h
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetAccessor.h"
#import "SurveyInfo.h"
#import "ObjectInfo.h"
#import "surveyDetailInfo.h"
#import "AnswerInfo.h"
#import "SurveyAnswerInfo.h"

#define kSurveyID               @"SurveyID"
#define kObjectID               @"ObjectID"

@interface SurveyAction : NSObject

/**
 *  我参与的问卷列表
 *
 *  @param Key      Key description
 *  @param OCID     在线课程ID
 *  @param finished finished description
 */
+ (void)getSurveyMyJoinListWithKey:(NSString *)Key
                              OCID:(long)OCID
                          finished:(FinishedBlock)finished;
/**
 *  获取调查问卷的被评价对象
 *
 *  @param SurveyID SurveyID description
 *  @param finished finished description
 */
+ (void)getSurveyToObjectWithSurveyID:(long)SurveyID
                             finished:(FinishedBlock)finished;
/**
 *  问卷调查详细信息
 *
 *  @param SurveyID SurveyID description
 *  @param finished finished description
 */
+ (void)getSurveyInfoWithSurveyID:(long)SurveyID
                         finished:(FinishedBlock)finished;
/**
 *  调查问卷的答案详细信息
 *
 *  @param SurveyID SurveyID description
 *  @param ObjectID ObjectID description
 *  @param finished finished description
 */
+ (void)getSurveyAnswerWithSurveyID:(long)SurveyID
                           ObjectID:(long)ObjectID
                           finished:(FinishedBlock)finished;
/**
 *  问卷调查详细及答案
 *
 *  @param SurveyID SurveyID description
 *  @param finished finished description
 */
+ (void)getSurveyAnswerInfoWithSurveyID:(long)SurveyID
                               finished:(FinishedBlock)finished;

/**
 *  问卷调查投票
 *
 *  @param SurveyID SurveyID description
 *  @param Conten   Conten description
 *  @param Status   Status description
 *  @param ObjectID 被评对象编号,无对象传0
 *  @param finished finished description
 */
+ (void)editSurveyAnswerwithSurveyID:(long)SurveyID
                              Conten:(NSString *)Conten
                              Status:(int)Status
                            ObjectID:(long)ObjectID
                            finished:(FinishedBlock)finished;

@end
