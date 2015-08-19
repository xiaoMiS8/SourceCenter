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
#define kFileID             @"FileID"
#define kIsFinish           @"IsFinish"

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
                           IsEssence:(int)IsEssence
                           IsMyStart:(BOOL)IsMyStart
                            IsMyJoin:(BOOL)IsMyJoin
                           SearchKey:(NSString *)SearchKey
                           PageIndex:(int)PageIndex
                            PageSize:(int)PageSize
                            finished:(FinishedBlock)finished;
/**
 *  论坛主题的详细信息
 *
 *  @param TopicID  论坛主题ID
 *  @param finished finished description
 */
+ (void)getAppForumTopicWithTopicID:(long)TopicID
                           finished:(FinishedBlock)finished;
/**
 *  获取论坛回复列表
 *
 *  @param TopicID  论坛主题ID
 *  @param finished finished description
 */
+ (void)getAppForumResponseInfoListWithTopicID:(long)TopicID
                                      finished:(FinishedBlock)finished;
/**
 *  论坛回复
 *
 *  @param TopicID  论坛主题ID
 *  @param ParentID 回复的父级
 *  @param Conten   内容
 *  @param finished finished description
 */
+ (void)addForumResponseWithTopicID:(long)TopicID
                           ParentID:(long)ParentID
                             Conten:(NSString *)Conten
                           finished:(FinishedBlock)finished;
/**
 *  论坛版块列表
 *
 *  @param OCID     在线课程Id
 *  @param finished finished description
 */
+ (void)getForumTypeListwithOCID:(long)OCID
                        finished:(FinishedBlock)finished;
/**
 *  新建讨论板块
 *
 *  @param OCID            在线课程Id
 *  @param CourseID        课程ID
 *  @param Title           标题
 *  @param IsEssence       是否精华
 *  @param IsPublic        是否公告板块
 *  @param Brief           简介
 *  @param TeachingClassID 教学班ID
 *  @param IsSys           是否系统
 *  @param finished        finished description
 */
+ (void)addForumTypeWithOCID:(long)OCID
                    CourseID:(long)CourseID
                       Title:(NSString *)Title
                   IsEssence:(BOOL)IsEssence
                    IsPublic:(BOOL)IsPublic
                       Brief:(NSString *)Brief
             TeachingClassID:(long)TeachingClassID
                       IsSys:(BOOL)IsSys
                    finished:(FinishedBlock)finished;
/**
 *  论坛版块修改
 *
 *  @param OCID            在线课程Id
 *  @param CourseID        课程ID
 *  @param Title           标题
 *  @param IsEssence       是否精华
 *  @param IsPublic        是否公告板块
 *  @param Brief           简介
 *  @param TeachingClassID 教学班ID
 *  @param IsSys           是否系统
 *  @param finished        finished description
 */
+ (void)updateForumTypeWithOCID:(long)OCID
                       CourseID:(long)CourseID
                          Title:(NSString *)Title
                      IsEssence:(BOOL)IsEssence
                       IsPublic:(BOOL)IsPublic
                          Brief:(NSString *)Brief
                TeachingClassID:(long)TeachingClassID
                          IsSys:(BOOL)IsSys
                       finished:(FinishedBlock)finished;
/**
 *  发帖
 *
 *  @param OCID        在线课程Id
 *  @param CourseID    课程ID
 *  @param ForumTypeID 板块ID,0表示全部版块
 *  @param GroupTaskID 小组讨论的编号，如果不是小组讨论中发帖，该编号设置为0
 *  @param Title       标题
 *  @param Conten      内容
 *  @param TopicType   发帖的主题类型; PBL中发帖，该编号设置为3
 *  @param Tags        标签 ,用逗号分隔;  Source --附件名称,SourceID --附件ID
 *  @param ChapterID   章节ID
 *  @param Source      没有传""
 *  @param SourceID    小组讨论任务编号没有传0
 *  @param finished    finished description
 */
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
/**
 *  删除板块
 *
 *  @param ForumTypeID 板块ID,0表示全部版块
 *  @param OCID        在线课程Id
 *  @param finished    finished description
 */
+ (void)deleteForumTypeWithForumTypeID:(long)ForumTypeID
                                  OCID:(long)OCID
                              finished:(FinishedBlock)finished;
/**
 *  教学班列表
 *
 *  @param OCID     在线课程Id
 *  @param finished finished description
 */
+ (void)getOCClassDropdownListWithOCID:(long)OCID
                              finished:(FinishedBlock)finished;
/**
 *  为论坛主题或回复点赞
 *
 *  @param TopicID    主题
 *  @param ResponseID 回复ID,0表示为主题加赞
 *  @param finished   finished description
 */
+ (void)updateForumMyIsGoodWithTopicID:(long)TopicID
                            ResponseID:(long)ResponseID
                              finished:(FinishedBlock)finished;
/**
 *  删除帖子
 *
 *  @param TopicID  论坛主题ID
 *  @param finished finished description
 */
+ (void)deleteForumTopicwithTopicID:(long)TopicID
                           finished:(FinishedBlock)finished;
/**
 *  删除回复
 *
 *  @param ResponseID 回复Id
 *  @param finished   finished description
 */
+ (void)deleteForumResponseWithResponseID:(long)ResponseID
                                 finished:(FinishedBlock)finished;
/**
 *  获取Mooc章的列表
 *
 *  @param OCID     在线课程Id
 *  @param finished finished description
 */
+ (void)getAppChapterzhangListWithOCID:(long)OCID
                              finished:(FinishedBlock)finished;
/**
 *  帖子设置置顶
 *
 *  @param TopicID  论坛主题ID
 *  @param finished finished description
 */
+ (void)setAppForumTopicIsTopWithTopicID:(long)TopicID
                                finished:(FinishedBlock)finished;
/**
 *  帖子设置精华
 *
 *  @param TopicID  论坛主题ID
 *  @param finished finished description
 */
+ (void)setAppForumTopicIsEssenceWithTopicID:(long)TopicID
                                    finished:(FinishedBlock)finished;
/**
 *  帖子分享到其他板块
 *
 *  @param TopicID  论坛主题ID
 *  @param finished finished description
 */
+ (void)addAppForumTopicTypeWithTopicID:(long)TopicID
                               finished:(FinishedBlock)finished;

@end
