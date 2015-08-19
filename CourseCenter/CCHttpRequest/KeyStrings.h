//
//  KeyStrings.h
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#ifndef CourseCenter_KeyStrings_h
#define CourseCenter_KeyStrings_h

#pragma mark- UserAction

    //登录
#define KLogin                          @"Login"
    //注销
#define kLogout                         @"Logout"
    //得到个人信息
#define kgetUserInfo                    @"User_Get"
    //修改密码
#define kPwd_Upd                        @"Pwd_Upd"

#pragma mark- Index
    //推荐课程
#define kRecommendCourse_List           @"RecommendCourse_List"
    //全部课程
#define kOC_All_List                    @"OC_All_List"
    //学科列表
#define kSpecialtyType_Tree             @"SpecialtyType_Tree"
    //Mooc基本信息
#define kApp_OCMooc_Get                 @"App_OCMooc_Get"
    //课程章节
#define kChapterStudy_List              @"ChapterStudy_List"
    //章节下资料列表
#define kOCMoocFileStudy_List           @"OCMoocFileStudy_List"
    //章节下资料学习情况
#define kOCMoocStuFile_Add              @"OCMoocStuFile_Add"

#pragma mark- Notice

    //通知列表
#define kNoticeInfo_List                @"NoticeInfo_List"
    //通知回复列表
#define kNoticeResponse_List            @"NoticeResponse_List"
    //发布通知
#define kApp_Notice_Add                 @"App_Notice_Add"
    //回复通知
#define kNoticeResponse_ADD             @"NoticeResponse_ADD"
    //教师下网络教学班列表
#define kApp_TeacherOCClass_List        @"App_TeacherOCClass_List"

#pragma mark- Course


    //我的课程列表
#define kApp_OC_List                    @"App_OC_List"

#pragma mark- Msg 
    //获取未读消息数
#define kApp_UnReadMessageCount_get     @"App_UnReadMessageCount_get"
    //发送消息消息列表
#define kApp_Message_List               @"App_Message_List"
    //消息详细
#define kApp_Message_Get                @"App_Message_Get"
    //发送消息
#define kApp_Message_Add                @"App_Message_Add"
    //某人所在的所有教学班及组
#define kApp_OCClass_List               @"App_OCClass_List"
    //教学班下联系人
#define kApp_ClassUser_List             @"App_ClassUser_List"

#pragma mark- File

    //获取资源分类数量
#define kApp_FileCount_Get              @"App_FileCount_Get"
    //获取某人的课程名称列表
#define kApp_OCName_List                @"App_OCName_List"
    //获取资料的列表信息
#define kApp_File_Search                @"App_File_Search"

    //翻转课堂列表
#define kApp_OCFC_List                  @"App_OCFC_List"
    //翻转课堂小组信息
#define kApp_FCGroup_Get                @"App_FCGroup_Get"
    //获取课堂成员
#define kApp_FCGroupUser_List           @"App_FCGroupUser_List"
    //翻转课堂成绩排名
#define kApp_OCFCScoreRank_Get          @"App_OCFCScoreRank_Get"
    //翻转课堂导航信息
#define kOCFC_LearnNavInfo_Get          @"OCFC_LearnNavInfo_Get"

    //获取翻转课堂详细
#define kApp_OCFC_Get                   @"App_OCFC_Get"
    //线上课堂资料列表
#define kOCFCFile_List                  @"OCFCFile_List"
    //线上课堂作业列表
#define kOCFCLiveTest_List              @"OCFCLiveTest_List"
    //线上课堂互动列表
#define kOCFCLiveForum_List             @"OCFCLiveForum_List"
    //翻转课堂线下课堂列表
#define kOCFCOffline_List               @"OCFCOffline_List"
    //翻转课堂小组的成绩统计
#define kApp_OCFCScore_Group_Get        @"App_OCFCScore_Group_Get"



#endif
