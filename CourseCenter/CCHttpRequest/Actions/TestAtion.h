//
//  TestAtion.h
//  CourseCenter
//
//  Created by jian on 15/7/31.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetAccessor.h"
#import "TestInfo.h"
#import "TestPaperInfo.h"
#import "TestAnswerInfo.h"
#import "UserInfo.h"

#define kReson          @"Reson"
#define kAnswer         @"Answer"
#define kStatus         @"Status"

@interface TestAtion : NSObject

/**
 *  未提交作业列表
 *
 *  @param OCID     在线课程Id
 *  @param finished finished description
 */
+ (void)getAppTestNotSumbitListWithOCID:(long)OCID
                               finished:(FinishedBlock)finished;
/**
 *  已提交作业列表
 *
 *  @param OCID     在线课程Id
 *  @param finished finished description
 */
+ (void)getAppTestInfoSumbitListWithOCID:(long)OCID
                                finished:(FinishedBlock)finished;
/**
 *  补交作业申请提交
 *
 *  @param OCID     在线课程Id
 *  @param Type     Type(此处传1)
 *  @param TestID   TestID description
 *  @param Reson    Reson description
 *  @param finished finished description
 */
+ (void)addAppOCAffairsWithOCID:(long)OCID
                           Type:(int)Type
                         TestID:(long)TestID
                          Reson:(NSString *)Reson
                       finished:(FinishedBlock)finished;
/**
 *  用户是否有权限查看测试的内容
 *
 *  @param TestID   TestID description
 *  @param finished finished description
 */
+ (void)TestCanSeeTestWithTestID:(long)TestID
                        finished:(FinishedBlock)finished;
/**
 *  获取试卷的详细信息
 *
 *  @param PaperID  试卷编号
 *  @param TestID   作业考试编号
 *  @param finished finished description
 */
+ (void)getPaperInfoWithPaperID:(long)PaperID
                         TestID:(long)TestID
                       finished:(FinishedBlock)finished;
/**
 *  获取试卷保存的答案
 *
 *  @param TestID   作业考试编号
 *  @param finished finished description
 */
+ (void)getTestAnswerWithTestID:(long)TestID
                       finished:(FinishedBlock)finished;
/**
 *  暂存学生的答案信息
 *
 *  @param TestID   作业考试编号
 *  @param Answer   Answer -- 答案格式: ExerciseID + "wshgkjqbwhfbxlfrh_b" + (答案) + "wshgkjqbwhfbxlfrh_a"
 *  @param finished finished description
 */
+ (void)saveTestTempwithTestID:(long)TestID
                        Answer:(NSString *)Answer
                      finished:(FinishedBlock)finished;
/**
 *  提交学生的答案信息
 *
 *  @param TestID   作业考试编号
 *  @param Answer   Answer -- 答案格式: ExerciseID + "wshgkjqbwhfbxlfrh_b" + (答案) + "wshgkjqbwhfbxlfrh_a"
 *  @param finished finished description
 */
+ (void)SubmitTestWithTestID:(long)TestID
                      Answer:(NSString *)Answer
                    finished:(FinishedBlock)finished;
/**
 *  更新学生批阅状态
 *
 *  @param UserID   UserID description
 *  @param TestID   TestID description
 *  @param Status   11退回重做,23批阅完成,30成绩发放
 *  @param finished finished description
 */
+ (void)updateTestUserStatusWithUserID:(long)UserID
                                TestID:(long)TestID
                                Status:(int)Status
                              finished:(FinishedBlock)finished;
/**
 *  作业列表
 *
 *  @param OCID      OCID description
 *  @param Type       1.作业2考试3达标训练 4录入成绩,-1全部
 *  @param PageIndex PageIndex description
 *  @param PageSize  PageSize description
 *  @param finished  finished description
 */
+ (void)getTestListwithOCID:(long)OCID
                       Type:(int)Type
                  PageIndex:(int)PageIndex
                   PageSize:(int)PageSize
                   finished:(FinishedBlock)finished;
/**
 *  作业下的学生列表
 *
 *  @param TestID    TestID description
 *  @param PageIndex PageIndex description
 *  @param PageSize  PageSize description
 *  @param finished  finished description
 */
+ (void)getTestUserListWithTestID:(long)TestID
                        PageIndex:(int)PageIndex
                         PageSize:(int)PageSize
                         finished:(FinishedBlock)finished;

@end
