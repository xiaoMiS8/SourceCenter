//
//  BbsAction.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/29.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetAccessor.h"
#import "TopicInfo.h"

#define kOCID               @"OCID"
#define kForumTypeID        @"ForumTypeID"
#define kIsEssence          @"IsEssence"
#define kIsMyStart          @"IsMyStart"
#define kIsMyJoin           @"IsMyJoin"
#define kSearchKey          @"SearchKey"
#define kPageIndex          @"PageIndex"
#define kPageSize           @"PageSize"
#define kTopicID            @"TopicID"

@interface BbsAction : NSObject

/**
 *  @brief  获取论坛列表
 *
 *  @param OCID        OCID
 *  @param ForumTypeID 板块ID,0表示全部版块
 *  @param IsEssence   是否精华
 *  @param IsMyStart   是否我创建
 *  @param IsMyJoin    是否我参与
 *  @param SearchKey   关键字
 *  @param PageIndex   PageIndex
 *  @param PageSize    PageSize
 *  @param finished    finished
 */
+ (void)getAppForumTopicListWithOCID:(long)OCID
                         ForumTypeID:(long)ForumTypeID
                           IsEssence:(BOOL)IsEssence
                           IsMyStart:(BOOL)IsMyStart
                            IsMyJoin:(BOOL)IsMyJoin
                           SearchKey:(NSString *)SearchKey
                           PageIndex:(int)PageIndex
                            PageSize:(int)PageSize
                            finished:(FinishedBlock)finished;

+ (void)getAppForumTopicWithTopicID:(long)TopicID
                           finished:(FinishedBlock)finished;
+ (void)getAppForumResponseInfoListWithTopicID:(long)TopicID
                                      finished:(FinishedBlock)finished;

@end
