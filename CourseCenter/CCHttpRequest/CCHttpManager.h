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



@end
