//
//  FCourseInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/27.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetAccessor.h"

#define kOCID               @"OCID"
#define kFCID               @"FCID"

@interface FCourseAction : NSObject

/**
 *  @brief  翻转课堂列表
 *
 *  @param OCID     OCID
 *  @param finished finished
 */
+ (void)getAppOCFCListWithOCID:(long)OCID
                      finished:(FinishedBlock)finished;

/**
 *  @brief  翻转课堂小组信息
 *
 *  @param OCID     在线课程ID
 *  @param FCID     翻转课堂ID
 *  @param finished finished description
 */
+ (void)getAppFCGroupWithOCID:(long)OCID
                         FCID:(long)FCID
                     finished:(FinishedBlock)finished;
/**
 *  @brief  获取课堂成员
 *
 *  @param OCID     在线课程ID
 *  @param FCID     翻转课堂ID
 *  @param finished finished description
 */
+ (void)getAppFCGroupUserListWithOCID:(long)OCID
                                 FCID:(long)FCID
                             finished:(FinishedBlock)finished;
/**
 *  @brief  翻转课堂成绩排名
 *
 *  @param FCID     翻转课堂ID
 *  @param finished finished description
 */
+ (void)getAppOCFCScoreRankWithFCID:(long)FCID
                           finished:(FinishedBlock)finished;
/**
 *  @brief  翻转课堂导航信息
 *
 *  @param OCID     在线课程ID
 *  @param FCID     翻转课堂ID
 *  @param finished finished description
 */
+ (void)getOCFCLearnNavInfowithOCID:(long)OCID
                               FCID:(long)FCID finished:(FinishedBlock)finished;
/**
 *  @brief  获取翻转课堂详细
 *
 *  @param FCID      翻转课堂ID
 *  @param finished finished description
 */
+ (void)getAppOCFCWithFCID:(long)FCID
                  finished:(FinishedBlock)finished;
/**
 *  @brief  线上课堂资料列表
 *
 *  @param FCID      翻转课堂ID
 *  @param finished finished description
 */
+ (void)getOCFCFileListWithFCID:(long)FCID
                       finished:(FinishedBlock)finished;
/**
 *  @brief  线上课堂作业列表
 *
 *  @param FCID      翻转课堂ID
 *  @param finished finished description
 */
+ (void)getOCFCLiveTestListWithFCID:(long)FCID
                           finished:(FinishedBlock)finished;
/**
 *  @brief  线上课堂互动列表
 *
 *  @param FCID      翻转课堂ID
 *  @param finished finished description
 */
+ (void)getOCFCLiveForumListWithFCID:(long)FCID
                            finished:(FinishedBlock)finished;
/**
 *  @brief  翻转课堂线下课堂列表
 *
 *  @param FCID      翻转课堂ID
 *  @param finished finished description
 */
+ (void)getOCFCOfflineListWithFCID:(long)FCID
                          finished:(FinishedBlock)finished;
/**
 *  @brief  翻转课堂小组的成绩统计
 *
 *  @param FCID      翻转课堂ID
 *  @param finished finished description
 */
+ (void)getAppOCFCScoreGroupWithFCID:(long)FCID
                            finished:(FinishedBlock)finished;

@end
