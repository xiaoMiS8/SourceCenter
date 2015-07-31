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
#import "TopicResponseInfo.h"
#import "ForumTypeInfo.h"
#import "OCClassInfo.h"
#import "ChapterInfo.h"

#define kOCID               @"OCID"
#define kForumTypeID        @"ForumTypeID"
#define kIsEssence          @"IsEssence"
#define kIsMyStart          @"IsMyStart"
#define kIsMyJoin           @"IsMyJoin"
#define kSearchKey          @"SearchKey"
#define kPageIndex          @"PageIndex"
#define kPageSize           @"PageSize"
#define kTopicID            @"TopicID"
#define kParentID           @"ParentID"
#define kConten             @"Conten"
#define kCourseID           @"CourseID"
#define kTitle              @"Title"
#define kIsEssence          @"IsEssence"
#define kIsPublic           @"IsPublic"
#define kBrief              @"Brief"
#define kTeachingClassID    @"TeachingClassID"
#define kIsSys              @"IsSys"
#define kGroupTaskID        @"GroupTaskID"
#define kTopicType          @"TopicType"
#define kTags               @"Tags"
#define kChapterID          @"ChapterID"
#define kSource             @"Source"
#define kSourceID           @"SourceID"

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
+ (void)addForumResponseWithTopicID:(long)TopicID
                           ParentID:(long)ParentID
                             Conten:(NSString *)Conten
                           finished:(FinishedBlock)finished;
+ (void)getForumTypeListwithOCID:(long)OCID
                        finished:(FinishedBlock)finished;
+ (void)addForumTypeWithOCID:(long)OCID
                    CourseID:(long)CourseID
                       Title:(NSString *)Title
                   IsEssence:(BOOL)IsEssence
                    IsPublic:(BOOL)IsPublic
                       Brief:(NSString *)Brief
             TeachingClassID:(long)TeachingClassID
                       IsSys:(BOOL)IsSys
                    finished:(FinishedBlock)finished;
+ (void)updateForumTypeWithOCID:(long)OCID
                       CourseID:(long)CourseID
                          Title:(NSString *)Title
                      IsEssence:(BOOL)IsEssence
                       IsPublic:(BOOL)IsPublic
                          Brief:(NSString *)Brief
                TeachingClassID:(long)TeachingClassID
                          IsSys:(BOOL)IsSys
                       finished:(FinishedBlock)finished;
+ (void)addForumTopicWithOCID:(long)OCID
                     CourseID:(long)CourseID
                  ForumTypeID:(long)ForumTypeID
                  GroupTaskID:(long)GroupTaskID
                        Title:(NSString *)Title
                       Conten:(NSString *)Conten
                    TopicType:(int)TopicType
                         Tags:(NSArray *)Tags
                    ChapterID:(long)ChapterID
                       Source:(NSString *)Source
                     SourceID:(long)SourceID
                     finished:(FinishedBlock)finished;
+ (void)deleteForumTypeWithForumTypeID:(long)ForumTypeID
                                  OCID:(long)OCID
                              finished:(FinishedBlock)finished;
+ (void)getOCClassDropdownListWithOCID:(long)OCID
                              finished:(FinishedBlock)finished;
+ (void)updateForumMyIsGoodWithTopicID:(long)TopicID
                            ResponseID:(long)ResponseID
                              finished:(FinishedBlock)finished;
+ (void)deleteForumTopicwithTopicID:(long)TopicID
                           finished:(FinishedBlock)finished;
+ (void)deleteForumResponseWithResponseID:(long)ResponseID
                                 finished:(FinishedBlock)finished;
+ (void)getAppChapterzhangListWithOCID:(long)OCID
                              finished:(FinishedBlock)finished;
+ (void)setAppForumTopicIsTopWithTopicID:(long)TopicID
                                finished:(FinishedBlock)finished;
+ (void)setAppForumTopicIsEssenceWithTopicID:(long)TopicID
                                    finished:(FinishedBlock)finished;
+ (void)addAppForumTopicTypeWithTopicID:(long)TopicID
                               finished:(FinishedBlock)finished;

@end
