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

@end
