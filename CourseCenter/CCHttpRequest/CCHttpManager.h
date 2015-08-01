//
//  CCRequestManager.h
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserActions.h"
#import "IndexActions.h"
#import "NoticeActions.h"
#import "CourseActions.h"
#import "MsgAction.h"
#import "FileAction.h"
#import "FCourseAction.h"
#import "BbsAction.h"
#import "TestAtion.h"
#import "AffairsAction.h"
#import "SurveyAction.h"
@interface CCHttpManager : NSObject

#pragma mark- User

/**
 *  登录
 *
 *  @param loginName 用户名
 *  @param pwd       密码
 *  @param finished  finished
 */
- (void)loginWithLoginName:(NSString *)loginName
                       Pwd:(NSString *)pwd
                  finished:(FinishedBlock)finished;

/**
 *  注销
 *
 *  @param finished finished description
 */
- (void)LogoutWithfinished:(FinishedBlock)finished;

/**
 *  得到个人信息
 *
 *  @param finished finished description
 */
- (void)getUserInfoWithfinished:(FinishedBlock)finished;

/**
 *  密码修改
 *
 *  @param Ypwd     原始密码
 *  @param NPwd     新密码
 *  @param finished finished description
 */
- (void)updatePassWordWithYpwd:(NSString *)Ypwd
                          NPwd:(NSString *)NPwd
                      finished:(FinishedBlock)finished;

#pragma mark- Index

/**
 *  推荐课程
 *
 *  @param finished finished description
 */
- (void)getRecommendCourseListWithfinished:(FinishedBlock)finished;
/**
 *  全部课程
 *
 *  @param SpecialtyTypeID 学科ID SpecialtyTypeID，ParentID =-1，为全部
 *  @param key             关键字
 *  @param PageIndex       第几页
 *  @param PageSize        每页大小
 *  @param finished        finished description
 */
- (void)getOCAllListWithSpecialtyTypeID:(long)SpecialtyTypeID
                                    key:(NSString *)key
                              PageIndex:(int)PageIndex
                               PageSize:(int)PageSize
                               finished:(FinishedBlock)finished;
/**
 *  学科列表
 *
 *  @param ParentID 父级ID SpecialtyTypeID，ParentID =-1，为全部
 *  @param finished finished description
 */
- (void)getSpecialtyTypeTreeWithParentID:(long)ParentID
                                finished:(FinishedBlock)finished;
/**
 *  Mooc基本信息
 *
 *  @param OCID     父级ID
 *  @param finished finished description
 */
- (void)getAppOCMoocGetWithOCID:(long)OCID
                       finished:(FinishedBlock)finished;
/**
 *  课程章节
 *
 *  @param OCID     父级ID
 *  @param finished finished description
 */
- (void)getChapterStudyListwithOCID:(long)OCID
                           finished:(FinishedBlock)finished;
/**
 *  章节下资料列表
 *
 *  @param OCID      父级ID
 *  @param ChapterID 章节ID
 *  @param FileType  资料类型
 *  @param finished  finished description
 */
- (void)getOCMoocFileStudyListwithOCID:(long)OCID
                              ChapterID:(long)ChapterID
                               FileType:(int)FileType
                               finished:(FinishedBlock)finished;

#pragma mark- Notice

/**
 *  通知列表
 *
 *  @param OCID      在线课程ID
 *  @param SysID     系统ID 默认1
 *  @param ModuleID  0系统通知, 1课程通知 -1:全部
 *  @param PageIndex  第几页
 *  @param PageSize  每页多少个
 *  @param finished  finished description
 */
- (void)getNoticeInfoListWithOCID:(long)OCID
                            SysID:(long)SysID
                         ModuleID:(long)ModuleID
                        PageIndex:(int)PageIndex
                         PageSize:(int)PageSize
                         finished:(FinishedBlock)finished;
/**
 *  回复列表
 *
 *  @param NoticeID  通知ID
 *  @param PageIndex 第几页
 *  @param PageSize  每页多少个
 *  @param finished  finished description
 */
- (void)getNoticeResponseListWithNoticeID:(long)NoticeID
                                PageIndex:(int)PageIndex
                                 PageSize:(int)PageSize
                                 finished:(FinishedBlock)finished;
/**
 *  发布通知
 *
 *  @param Title     标题
 *  @param Conten    内容
 *  @param IsTop     是否置顶
 *  @param IsForMail 是否发送邮件
 *  @param IsForSMS  是否发送短信
 *  @param SourceIDs 网络教学班编号集合（逗号分隔）)
 *  @param finished  finished description
 */
- (void)AddAppNoticeWithTitle:(NSString *)Title
                       Conten:(NSString *)Conten
                        IsTop:(BOOL)IsTop
                    IsForMail:(BOOL)IsForMail
                     IsForSMS:(BOOL)IsForSMS
                    SourceIDs:(NSArray *)SourceIDs
                     finished:(FinishedBlock)finished;
/**
 *  回复通知
 *
 *  @param NoticeID  通知ID
 *  @param Conten    内容
 *  @param finished  finished description
 */
- (void)AddNoticeResponseWithNoticeID:(long)NoticeID
                               Conten:(NSString *)Conten
                             finished:(FinishedBlock)finished;
/**
 *  教师下网络教学班列表
 *
 *  @param Key  关键字
 *  @param IsHistroy 是否历史教学班-1全部
 *  @param PageIndex  第几页
 *  @param PageSize  每页多少个
 *  @param finished  finished description
 */
- (void)getAppTeacherOCClass_ListWithKey:(NSString *)Key
                               IsHistroy:(BOOL)IsHistroy
                               PageIndex:(int)PageIndex
                                PageSize:(int)PageSize
                                finished:(FinishedBlock)finished;
#pragma mark- Course

/**
 *  我的课程列表
 *
 *  @param IsHistroy      是否历史课程默认-1全部
 *  @param finished  finished description
 */
- (void)getAppOCListWithIsHistroy:(int)IsHistroy
                         finished:(FinishedBlock) finished;
/**
 *  可以报名的网络招生班级列表
 *
 *  @param OCID      OCID
 *  @param finished  finished description
 */
- (void)getOCMoocRecruitCanListWithOCID:(long)OCID
                               finished:(FinishedBlock)finished;
/**
 *  报名网络招生班级
 *
 *  @param RecruitID      RecruitID
 *  @param finished  finished description
 */
- (void)jsonOCMoocRecruitClassWithRecruitID:(long)RecruitID
                                   finished:(FinishedBlock)finished;
/**
 *  注册在线教学班
 *
 *  @param RegNum    注册码
 *  @param OCID      OCID
 *  @param finished  finished description
 */
- (void)OCRegisterWithRegNum:(NSString *)RegNum
                        OCID:(long)OCID
                    finished:(FinishedBlock)finished;

#pragma mark-Msg
/**
 *  @brief  获取未读消息数
 *
 *  @param finished finished description
 */
- (void)getAppUnReadMessageCountWithfinished:(FinishedBlock)finished;
/**
 *  @brief  发送消息消息列表
 *
 *  @param key       关键词
 *  @param PageIndex 第几页
 *  @param PageSize  每页大小
 */
- (void)getAppMessageListWithkey:(NSString *)key
                       PageIndex:(int)PageIndex
                        PageSize:(int)PageSize
                        finished:(FinishedBlock)finished;
/**
 *  @brief  消息详细
 *
 *  @param UserID  用户Id
 *  @param finished finished
 */
- (void)getAppMessageWithUserID:(long)UserID
                       finished:(FinishedBlock)finished;
/**
 *  @brief  发送消息
 *
 *  @param Title          Title
 *  @param Conten         Conten
 *  @param ReceiveUserIDs 收信人ID集合
 *  @param finished       finished
 */
- (void)addAppMessageWithTitle:(NSString *)Title
                        Conten:(NSString *)Conten
                ReceiveUserIDs:(NSArray *)ReceiveUserIDs
                      finished:(FinishedBlock)finished;
/**
 *  @brief  某人所在的所有教学班及组
 *
 *  @param finished finished
 */
- (void)getOCClassListWithfinished:(FinishedBlock)finished;

/**
 *  @brief  教学班下联系人
 *
 *  @param ID          ID
 *  @param Type         1教学班, 2组, -1全部
 *  @param finished       finished
 */
- (void)getAppClassUserListwithID:(long)ID
                             Type:(int)Type
                         finished:(FinishedBlock)finished;

#pragma mark- File

/**
 *  @brief  获取资源分类数量
 *
 *  @param OCID     OCID
 *  @param finished finished
 */
- (void)getAppFileCountWithOCID:(long)OCID
                       finished:(FinishedBlock)finished;
/**
 *  @brief  获取某人的课程名称列表
 *
 *  @param role      1:教师, 2:学生
 *  @param IsHistroy IsHistroy
 *  @param finished  finished
 */
- (void)getAppOCNameListWithrole:(int)role
                       IsHistroy:(BOOL)IsHistroy
                        finished:(FinishedBlock)finished;
/**
 *  @brief  获取资料的列表信息
 *
 *  @param Searchkey 搜索关键词
 *  @param OCID      OCID
 *  @param FileType  文件类型
 *  @param PageIndex 第几页
 *  @param PageSize  每页大小
 *  @param finished  finished
 */
- (void)getAppFileSearchwithSearchkey:(NSString *)Searchkey
                                 OCID:(long)OCID
                             FileType:(int)FileType
                            PageIndex:(int)PageIndex
                             PageSize:(int)PageSize
                             finished:(FinishedBlock)finished;

#pragma mark- FCourse

/**
 *  @brief  翻转课堂列表
 *
 *  @param OCID     OCID
 *  @param finished finished
 */
- (void)getAppOCFCListWithOCID:(long)OCID
                      finished:(FinishedBlock)finished;

/**
 *  @brief  翻转课堂小组信息
 *
 *  @param OCID     在线课程ID
 *  @param FCID     翻转课堂ID
 *  @param finished finished description
 */
- (void)getAppFCGroupWithOCID:(long)OCID
                         FCID:(long)FCID
                     finished:(FinishedBlock)finished;
/**
 *  @brief  获取课堂成员
 *
 *  @param OCID     在线课程ID
 *  @param FCID     翻转课堂ID
 *  @param finished finished description
 */
- (void)getAppFCGroupUserListWithOCID:(long)OCID
                                 FCID:(long)FCID
                             finished:(FinishedBlock)finished;

/**
 *  @brief  翻转课堂成绩排名
 *
 *  @param FCID     翻转课堂ID
 *  @param finished finished description
 */
- (void)getAppOCFCScoreRankWithFCID:(long)FCID
                           finished:(FinishedBlock)finished;
/**
 *  @brief  翻转课堂导航信息
 *
 *  @param OCID     在线课程ID
 *  @param FCID     翻转课堂ID
 *  @param finished finished description
 */
- (void)getOCFCLearnNavInfowithOCID:(long)OCID
                               FCID:(long)FCID finished:(FinishedBlock)finished;
/**
 *  @brief  获取翻转课堂详细
 *
 *  @param FCID      翻转课堂ID
 *  @param finished finished description
 */
- (void)getAppOCFCWithFCID:(long)FCID
                  finished:(FinishedBlock)finished;
/**
 *  @brief  线上课堂资料列表
 *
 *  @param FCID      翻转课堂ID
 *  @param finished finished description
 */
- (void)getOCFCFileListWithFCID:(long)FCID
                       finished:(FinishedBlock)finished;
/**
 *  @brief  线上课堂作业列表
 *
 *  @param FCID      翻转课堂ID
 *  @param finished finished description
 */
- (void)getOCFCLiveTestListWithFCID:(long)FCID
                           finished:(FinishedBlock)finished;
/**
 *  @brief  线上课堂互动列表
 *
 *  @param FCID      翻转课堂ID
 *  @param finished finished description
 */
- (void)getOCFCLiveForumListWithFCID:(long)FCID
                            finished:(FinishedBlock)finished;
/**
 *  @brief  翻转课堂线下课堂列表
 *
 *  @param FCID      翻转课堂ID
 *  @param finished finished description
 */
- (void)getOCFCOfflineListWithFCID:(long)FCID
                          finished:(FinishedBlock)finished;
/**
 *  @brief  翻转课堂小组的成绩统计
 *
 *  @param FCID      翻转课堂ID
 *  @param finished finished description
 */
- (void)getAppOCFCScoreGroupWithFCID:(long)FCID
                            finished:(FinishedBlock)finished;
#pragma mark- BBS

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
- (void)getAppForumTopicListWithOCID:(long)OCID
                         ForumTypeID:(long)ForumTypeID
                           IsEssence:(BOOL)IsEssence
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
- (void)getAppForumTopicWithTopicID:(long)TopicID
                           finished:(FinishedBlock)finished;
/**
 *  获取论坛回复列表
 *
 *  @param TopicID  论坛主题ID
 *  @param finished finished description
 */
- (void)getAppForumResponseInfoListWithTopicID:(long)TopicID
                                      finished:(FinishedBlock)finished;
/**
 *  论坛回复
 *
 *  @param TopicID  论坛主题ID
 *  @param ParentID 回复的父级
 *  @param Conten   内容
 *  @param finished finished description
 */
- (void)addForumResponseWithTopicID:(long)TopicID
                           ParentID:(long)ParentID
                             Conten:(NSString *)Conten
                           finished:(FinishedBlock)finished;
/**
 *  论坛版块列表
 *
 *  @param OCID     在线课程Id
 *  @param finished finished description
 */
- (void)getForumTypeListwithOCID:(long)OCID
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
- (void)addForumTypeWithOCID:(long)OCID
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
- (void)updateForumTypeWithOCID:(long)OCID
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
- (void)addForumTopicWithOCID:(long)OCID
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
- (void)deleteForumTypeWithForumTypeID:(long)ForumTypeID
                                  OCID:(long)OCID
                              finished:(FinishedBlock)finished;
/**
 *  教学班列表
 *
 *  @param OCID     在线课程Id
 *  @param finished finished description
 */
- (void)getOCClassDropdownListWithOCID:(long)OCID
                              finished:(FinishedBlock)finished;
/**
 *  为论坛主题或回复点赞
 *
 *  @param TopicID    主题
 *  @param ResponseID 回复ID,0表示为主题加赞
 *  @param finished   finished description
 */
- (void)updateForumMyIsGoodWithTopicID:(long)TopicID
                            ResponseID:(long)ResponseID
                              finished:(FinishedBlock)finished;
/**
 *  删除帖子
 *
 *  @param TopicID  论坛主题ID
 *  @param finished finished description
 */
- (void)deleteForumTopicwithTopicID:(long)TopicID
                           finished:(FinishedBlock)finished;
/**
 *  删除回复
 *
 *  @param ResponseID 回复Id
 *  @param finished   finished description
 */
- (void)deleteForumResponseWithResponseID:(long)ResponseID
                                 finished:(FinishedBlock)finished;
/**
 *  获取Mooc章的列表
 *
 *  @param OCID     在线课程Id
 *  @param finished finished description
 */
- (void)getAppChapterzhangListWithOCID:(long)OCID
                              finished:(FinishedBlock)finished;
/**
 *  帖子设置置顶
 *
 *  @param TopicID  论坛主题ID
 *  @param finished finished description
 */
- (void)setAppForumTopicIsTopWithTopicID:(long)TopicID
                                finished:(FinishedBlock)finished;
/**
 *  帖子设置精华
 *
 *  @param TopicID  论坛主题ID
 *  @param finished finished description
 */
- (void)setAppForumTopicIsEssenceWithTopicID:(long)TopicID
                                    finished:(FinishedBlock)finished;
/**
 *  帖子分享到其他板块
 *
 *  @param TopicID  论坛主题ID
 *  @param finished finished description
 */
- (void)addAppForumTopicTypeWithTopicID:(long)TopicID
                               finished:(FinishedBlock)finished;

#pragma mark -Test

/**
 *  未提交作业列表
 *
 *  @param OCID     在线课程Id
 *  @param finished finished description
 */
- (void)getAppTestNotSumbitListWithOCID:(long)OCID
                               finished:(FinishedBlock)finished;
/**
 *  已提交作业列表
 *
 *  @param OCID     在线课程Id
 *  @param finished finished description
 */
- (void)getAppTestInfoSumbitListWithOCID:(long)OCID
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
- (void)addAppOCAffairsWithOCID:(long)OCID
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
- (void)TestCanSeeTestWithTestID:(long)TestID
                        finished:(FinishedBlock)finished;
/**
 *  获取试卷的详细信息
 *
 *  @param PaperID  试卷编号
 *  @param TestID   作业考试编号
 *  @param finished finished description
 */
- (void)getPaperInfoWithPaperID:(long)PaperID
                         TestID:(long)TestID
                       finished:(FinishedBlock)finished;
/**
 *  获取试卷保存的答案
 *
 *  @param TestID   作业考试编号
 *  @param finished finished description
 */
- (void)getTestAnswerWithTestID:(long)TestID
                       finished:(FinishedBlock)finished;
/**
 *  暂存学生的答案信息
 *
 *  @param TestID   作业考试编号
 *  @param Answer   Answer -- 答案格式: ExerciseID + "wshgkjqbwhfbxlfrh_b" + (答案) + "wshgkjqbwhfbxlfrh_a"
 *  @param finished finished description
 */
- (void)saveTestTempwithTestID:(long)TestID
                        Answer:(NSString *)Answer
                      finished:(FinishedBlock)finished;
/**
 *  提交学生的答案信息
 *
 *  @param TestID   作业考试编号
 *  @param Answer   Answer -- 答案格式: ExerciseID + "wshgkjqbwhfbxlfrh_b" + (答案) + "wshgkjqbwhfbxlfrh_a"
 *  @param finished finished description
 */
- (void)SubmitTestWithTestID:(long)TestID
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
- (void)updateTestUserStatusWithUserID:(long)UserID
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
- (void)getTestListwithOCID:(long)OCID
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
- (void)getTestUserListWithTestID:(long)TestID
                        PageIndex:(int)PageIndex
                         PageSize:(int)PageSize
                         finished:(FinishedBlock)finished;

#pragma mark- Affairs
/**
 *  事务申请列表
 *
 *  @param Type      1 我审核的事务, 2 我申请的事务
 *  @param OCID      在线课程ID
 *  @param IsHistory 1 历史事务  0 待处理事务  -1 全部
 *  @param PageIndex PageIndex description
 *  @param PageSize  PageSize description
 *  @param finished  finished description
 */
- (void)getAffairsListWithType:(int)Type
                          OCID:(long)OCID
                     IsHistory:(BOOL)IsHistory
                     PageIndex:(int)PageIndex
                      PageSize:(int)PageSize
                      finished:(FinishedBlock)finished;
/**
 *  事务审核
 *
 *  @param AffairID AffairID description
 *  @param Status   状态 0:未审核,1:拒绝, 2:同意
 *  @param finished finished description
 */
- (void)updateOCAffairsStatusWithAffairID:(long)AffairID Status:(int)Status finished:(FinishedBlock)finished;

#pragma mark- Survey

/**
 *  我参与的问卷列表
 *
 *  @param Key      Key description
 *  @param OCID     在线课程ID
 *  @param finished finished description
 */
- (void)getSurveyMyJoinListWithKey:(NSString *)Key
                              OCID:(long)OCID
                          finished:(FinishedBlock)finished;
/**
 *  获取调查问卷的被评价对象
 *
 *  @param SurveyID SurveyID description
 *  @param finished finished description
 */
- (void)getSurveyToObjectWithSurveyID:(long)SurveyID
                             finished:(FinishedBlock)finished;
/**
 *  问卷调查详细信息
 *
 *  @param SurveyID SurveyID description
 *  @param finished finished description
 */
- (void)getSurveyInfoWithSurveyID:(long)SurveyID
                         finished:(FinishedBlock)finished;
/**
 *  调查问卷的答案详细信息
 *
 *  @param SurveyID SurveyID description
 *  @param ObjectID ObjectID description
 *  @param finished finished description
 */
- (void)getSurveyAnswerWithSurveyID:(long)SurveyID
                           ObjectID:(long)ObjectID
                           finished:(FinishedBlock)finished;
/**
 *  问卷调查详细及答案
 *
 *  @param SurveyID SurveyID description
 *  @param finished finished description
 */
- (void)getSurveyAnswerInfoWithSurveyID:(long)SurveyID
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
- (void)editSurveyAnswerwithSurveyID:(long)SurveyID
                              Conten:(NSString *)Conten
                              Status:(int)Status
                            ObjectID:(long)ObjectID
                            finished:(FinishedBlock)finished;

@end
