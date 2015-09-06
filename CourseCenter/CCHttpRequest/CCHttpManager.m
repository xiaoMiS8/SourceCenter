//
//  CCRequestManager.m
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "CCHttpManager.h"

@implementation CCHttpManager

- (void)loginWithLoginName:(NSString *)loginName
                       Pwd:(NSString *)pwd
                  finished:(FinishedBlock)finished {
    [UserActions loginWithLoginName:loginName
                                Pwd:pwd
                           finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)LogoutWithfinished:(FinishedBlock)finished {
    [UserActions LogoutWithfinished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getUserInfoWithfinished:(FinishedBlock)finished {
    [UserActions getUserInfoWithfinished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)updatePassWordWithYpwd:(NSString *)Ypwd
                          NPwd:(NSString *)NPwd
                      finished:(FinishedBlock)finished {
    [UserActions updatePassWordWithYpwd:Ypwd
                                   NPwd:NPwd
                               finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}
- (void)uploadPictureWithSourceID:(long)SourceID
                           Source:(NSString *)Source
                             File:(NSData *)File
                         finished:(FinishedBlock)finished{
    [UserActions uploadPictureWithSourceID:SourceID
                                    Source:Source
                                    File:File
                                  finished:^(EnumServerStatus status, NSObject *object)
                                      {
        finished(status, object);
    }];
}

- (void)chooseSchoolWithOpt:(NSString *)Opt
                        key:(NSString *)key
                   finished:(FinishedBlock)finished{
    [UserActions chooseSchoolWithOpt:Opt key:key finished:^(EnumServerStatus status, NSObject *object) {
       finished(status, object);
    }];
}

- (void)getRecommendCourseListWithfinished:(FinishedBlock)finished {
    [IndexActions getRecommendCourseListWithfinished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getOCAllListWithSpecialtyTypeID:(long)SpecialtyTypeID
                                    key:(NSString *)key
                              PageIndex:(int)PageIndex
                               PageSize:(int)PageSize
                               finished:(FinishedBlock)finished {
    [IndexActions getOCAllListWithSpecialtyTypeID:SpecialtyTypeID
                                              key:key
                                        PageIndex:PageIndex
                                         PageSize:PageSize
                                         finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getSpecialtyTypeTreeWithParentID:(long)ParentID
    SearchKey:(NSString *)searchKey finished:(FinishedBlock)finished {
    [IndexActions getSpecialtyTypeTreeWithParentID:ParentID
                                        SearchKey:searchKey finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getAppOCMoocGetWithOCID:(long)OCID
                       finished:(FinishedBlock)finished {
    [IndexActions getAppOCMoocGetWithOCID:OCID
                                 finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getChapterStudyListwithOCID:(long)OCID
                           finished:(FinishedBlock)finished {
    [IndexActions getChapterStudyListwithOCID:OCID
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getOCMoocFileStudyListwithOCID:(long)OCID
                             ChapterID:(long)ChapterID
                              FileType:(int)FileType
                              finished:(FinishedBlock)finished {
    [IndexActions getOCMoocFileStudyListwithOCID:OCID
                                       ChapterID:ChapterID
                                        FileType:FileType
                                        finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)addOCMoocStuFilewithChapterID:(long)ChapterID
                               FileID:(int)FileID
                             IsFinish:(int)IsFinish
                             finished:(FinishedBlock)finished{
    [IndexActions addOCMoocStuFilewithChapterID:ChapterID
                                       FileID:FileID
                                       IsFinish:IsFinish
                                       finished:^(EnumServerStatus status, NSObject *object) {
        finished(status,object);
    }];
    
}

- (void)addOCMoocStuFileTimeCountwithChapterID:(long)ChapterID
                                        FileID:(long)FileID
                                     TimeCount:(long)TimeCount
                                      finished:(FinishedBlock)finished{
    [IndexActions addOCMoocStuFileTimeCountwithChapterID:ChapterID
                                         FileID:FileID
                                       TimeCount:TimeCount
                                       finished:^(EnumServerStatus status, NSObject *object) {
                                           finished(status,object);
   }];
}

- (void)addOCMoocStuFileStudyTimeswithChapterID:(long)OCID
                                         FileID:(long)FileID
                                     StudyTimes:(long)StudyTimes
                                       finished:(FinishedBlock)finished{
    [IndexActions addOCMoocStuFileStudyTimeswithChapterID:OCID
                                                  FileID:FileID
                                               StudyTimes:StudyTimes
                                                finished:^(EnumServerStatus status, NSObject *object) {
                                                    finished(status,object);
   }];
}
- (void)addOCMoocStuFileSecondswithChapterID:(long)ChapterID
                                      FileID:(long)FileID
                                     Seconds:(long)Seconds
                                    finished:(FinishedBlock)finished{
    [IndexActions addOCMoocStuFileSecondswithChapterID:ChapterID
                                                   FileID:FileID
                                                   Seconds:Seconds
                                                 finished:^(EnumServerStatus status, NSObject *object) {
                                                     finished(status,object);
   }];
}

- (void)OCMoocStuFilePlayPausewithChapterID:(long)ChapterID
                                     FileID:(long)FileID
                                PlayOrPause:(int)PlayOrPause
                                   finished:(FinishedBlock)finished{
     [IndexActions OCMoocStuFilePlayPausewithChapterID:ChapterID
                                                FileID:FileID
                                           PlayOrPause:PlayOrPause
                                              finished:^(EnumServerStatus status, NSObject *object) {
                                                  finished(status,object);
   }];
}


- (void)getNoticeInfoListWithOCID:(long)OCID
                            SysID:(long)SysID
                         ModuleID:(long)ModuleID
                        PageIndex:(int)PageIndex
                         PageSize:(int)PageSize
                         finished:(FinishedBlock)finished {
    [NoticeActions getNoticeInfoListWithOCID:OCID
                                       SysID:SysID
                                    ModuleID:ModuleID
                                   PageIndex:PageIndex
                                    PageSize:PageSize
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getNoticeResponseListWithNoticeID:(long)NoticeID
                                PageIndex:(int)PageIndex
                                 PageSize:(int)PageSize
                                 finished:(FinishedBlock)finished {
    [NoticeActions getNoticeResponseListWithNoticeID:NoticeID
                                           PageIndex:PageIndex
                                            PageSize:PageSize
                                            finished:^(EnumServerStatus status, NSObject *object) {
        finished(status ,object);
    }];
}

- (void)AddAppNoticeWithTitle:(NSString *)Title
                       Conten:(NSString *)Conten
                        IsTop:(BOOL)IsTop
                    IsForMail:(BOOL)IsForMail
                     IsForSMS:(BOOL)IsForSMS
                    SourceIDs:(NSArray *)SourceIDs
                     finished:(FinishedBlock)finished {
    [NoticeActions AddAppNoticeWithTitle:Title
                                  Conten:Conten
                                   IsTop:IsTop
                               IsForMail:IsForMail
                                IsForSMS:IsForSMS
                               SourceIDs:SourceIDs
                                finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)AddNoticeResponseWithNoticeID:(long)NoticeID
                               Conten:(NSString *)Conten
                             finished:(FinishedBlock)finished {
    [NoticeActions AddNoticeResponseWithNoticeID:NoticeID
                                          Conten:Conten
                                        finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getAppTeacherOCClass_ListWithKey:(NSString *)Key IsHistroy:(BOOL)IsHistroy PageIndex:(int)PageIndex PageSize:(int)PageSize finished:(FinishedBlock)finished {
    [NoticeActions getAppTeacherOCClass_ListWithKey:Key
                                          IsHistroy:IsHistroy
                                          PageIndex:PageIndex
                                           PageSize:PageSize
                                           finished:^(EnumServerStatus status, NSObject *object) {
                                               finished(status, object);
                                           }];
}

- (void)getAppOCListWithIsHistroy:(int)IsHistroy
                         finished:(FinishedBlock) finished {
    [CourseActions getAppOCListWithIsHistroy:IsHistroy
                                    finished:^(EnumServerStatus status, NSObject *object) {
                                        finished(status, object);
                                    }];
}

- (void)getOCMoocRecruitCanListWithOCID:(long)OCID
                               finished:(FinishedBlock)finished {
    [CourseActions getOCMoocRecruitCanListWithOCID:OCID
                                          finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)jsonOCMoocRecruitClassWithRecruitID:(long)RecruitID
                                   finished:(FinishedBlock)finished {
    [CourseActions jsonOCMoocRecruitClassWithRecruitID:RecruitID
                                              finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)OCRegisterWithRegNum:(NSString *)RegNum
                        OCID:(long)OCID
                    finished:(FinishedBlock)finished {
    [CourseActions OCRegisterWithRegNum:RegNum
                                   OCID:OCID
                               finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getAppUnReadMessageCountWithfinished:(FinishedBlock)finished {
    [MsgAction getAppUnReadMessageCountWithfinished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getAppMessageListWithkey:(NSString *)key
                       PageIndex:(int)PageIndex
                        PageSize:(int)PageSize
                        finished:(FinishedBlock)finished {
    [MsgAction getAppMessageListWithkey:key
                              PageIndex:PageIndex
                               PageSize:PageSize
                               finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
                               }];
}

- (void)getAppMessageWithUserID:(long)UserID
                       finished:(FinishedBlock)finished {
    [MsgAction getAppMessageWithUserID:UserID
                              finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)addAppMessageWithTitle:(NSString *)Title
                        Conten:(NSString *)Conten
                ReceiveUserIDs:(NSString *)ReceiveUserIDs
                      finished:(FinishedBlock)finished {
    [MsgAction addAppMessageWithTitle:Title
                               Conten:Conten
                       ReceiveUserIDs:ReceiveUserIDs
                             finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getOCClassListWithfinished:(FinishedBlock)finished {
    [MsgAction getOCClassListWithfinished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getAppClassUserListwithID:(long)ID
                             Type:(int)Type
                         finished:(FinishedBlock)finished {
    [MsgAction getAppClassUserListwithID:ID
                                    Type:Type
                                finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}


- (void)getAppFileCountWithOCID:(long)OCID
                       finished:(FinishedBlock)finished {
    [FileAction getAppFileCountWithOCID:OCID
                               finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getAppOCNameListWithrole:(int)role
                       IsHistroy:(BOOL)IsHistroy
                        finished:(FinishedBlock)finished {
    [FileAction getAppOCNameListWithrole:role
                               IsHistroy:IsHistroy
                                finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
    
}

- (void)getAppFileSearchwithSearchkey:(NSString *)Searchkey
                                 OCID:(long)OCID
                             FileType:(int)FileType
                            PageIndex:(int)PageIndex
                             PageSize:(int)PageSize
                             finished:(FinishedBlock)finished {
    [FileAction getAppFileSearchwithSearchkey:Searchkey
                                         OCID:OCID
                                     FileType:FileType
                                    PageIndex:PageIndex
                                     PageSize:PageSize
                                     finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
    
}

- (void)getAppOCFCListWithOCID:(long)OCID
                      finished:(FinishedBlock)finished {
    [FCourseAction getAppOCFCListWithOCID:OCID
                                 finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getAppFCGroupWithOCID:(long)OCID
                         FCID:(long)FCID
                     finished:(FinishedBlock)finished {
    [FCourseAction getAppFCGroupWithOCID:OCID
                                    FCID:FCID
                                finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getAppFCGroupUserListWithOCID:(long)OCID
                                 FCID:(long)FCID
                             finished:(FinishedBlock)finished {
    [FCourseAction getAppFCGroupUserListWithOCID:OCID
                                            FCID:FCID
                                        finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getAppOCFCScoreRankWithFCID:(long)FCID
                           finished:(FinishedBlock)finished {
    [FCourseAction getAppOCFCScoreRankWithFCID:FCID finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getOCFCLearnNavInfowithOCID:(long)OCID
                               FCID:(long)FCID finished:(FinishedBlock)finished {
    [FCourseAction getOCFCLearnNavInfowithOCID:OCID
                                          FCID:FCID
                                      finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getAppOCFCWithFCID:(long)FCID
                  finished:(FinishedBlock)finished {
    [FCourseAction getAppOCFCWithFCID:FCID
                             finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getOCFCFileListWithFCID:(long)FCID
                       finished:(FinishedBlock)finished {
    [FCourseAction getOCFCFileListWithFCID:FCID
                                  finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}
- (void)getOCFCLiveTestListWithFCID:(long)FCID
                           finished:(FinishedBlock)finished {
    [FCourseAction getOCFCLiveTestListWithFCID:FCID
                                      finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}
- (void)getOCFCLiveForumListWithFCID:(long)FCID
                            finished:(FinishedBlock)finished {
    [FCourseAction getOCFCLiveForumListWithFCID:FCID
                                       finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getOCFCOfflineListWithFCID:(long)FCID
                          finished:(FinishedBlock)finished {
    [FCourseAction getOCFCOfflineListWithFCID:FCID
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getAppOCFCScoreGroupWithFCID:(long)FCID
                            finished:(FinishedBlock)finished {
   [FCourseAction getAppOCFCScoreGroupWithFCID:FCID
                                      finished:^(EnumServerStatus status, NSObject *object) {
       finished(status, object);
   }];
}

- (void)getAppForumTopicListWithOCID:(long)OCID
                         ForumTypeID:(long)ForumTypeID
                           IsEssence:(int)IsEssence
                           IsMyStart:(BOOL)IsMyStart
                            IsMyJoin:(BOOL)IsMyJoin
                           SearchKey:(NSString *)SearchKey
                           PageIndex:(int)PageIndex
                            PageSize:(int)PageSize
                            finished:(FinishedBlock)finished {
    [BbsAction getAppForumTopicListWithOCID:OCID
                                ForumTypeID:ForumTypeID
                                  IsEssence:IsEssence
                                  IsMyStart:IsMyStart
                                   IsMyJoin:IsMyJoin
                                  SearchKey:SearchKey
                                  PageIndex:PageIndex
                                   PageSize:PageSize
                                   finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getAppForumTopicWithTopicID:(long)TopicID
                           finished:(FinishedBlock)finished {
    [BbsAction getAppForumTopicWithTopicID:TopicID
                                  finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getAppForumResponseInfoListWithTopicID:(long)TopicID
                                      finished:(FinishedBlock)finished {
    [BbsAction getAppForumResponseInfoListWithTopicID:TopicID
                                             finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)addForumResponseWithTopicID:(long)TopicID
                           ParentID:(long)ParentID
                             Conten:(NSString *)Conten
                           finished:(FinishedBlock)finished {
    [BbsAction addForumResponseWithTopicID:TopicID
                                  ParentID:ParentID
                                    Conten:Conten
                                  finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}


- (void)getForumTypeListwithOCID:(long)OCID
                        finished:(FinishedBlock)finished {
    [BbsAction getForumTypeListwithOCID:OCID
                               finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)addForumTypeWithOCID:(long)OCID
                    CourseID:(long)CourseID
                       Title:(NSString *)Title
                   IsEssence:(BOOL)IsEssence
                    IsPublic:(BOOL)IsPublic
                       Brief:(NSString *)Brief
             TeachingClassID:(long)TeachingClassID
                       IsSys:(BOOL)IsSys
                    finished:(FinishedBlock)finished {
    
    [BbsAction addForumTypeWithOCID:OCID
                           CourseID:CourseID
                              Title:Title
                          IsEssence:IsEssence
                           IsPublic:IsPublic
                              Brief:Brief
                    TeachingClassID:TeachingClassID
                              IsSys:IsSys
                           finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)updateForumTypeWithOCID:(long)OCID
                       CourseID:(long)CourseID
                          Title:(NSString *)Title
                      IsEssence:(BOOL)IsEssence
                       IsPublic:(BOOL)IsPublic
                          Brief:(NSString *)Brief
                TeachingClassID:(long)TeachingClassID
                          IsSys:(BOOL)IsSys
                       finished:(FinishedBlock)finished {
    [BbsAction updateForumTypeWithOCID:OCID
                              CourseID:CourseID
                                 Title:Title
                             IsEssence:IsEssence
                              IsPublic:IsPublic
                                 Brief:Brief
                       TeachingClassID:TeachingClassID
                                 IsSys:IsSys
                              finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

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
                     finished:(FinishedBlock)finished {
    
    [BbsAction addForumTopicWithOCID:OCID
                            CourseID:CourseID
                         ForumTypeID:ForumTypeID
                         GroupTaskID:GroupTaskID
                               Title:Title
                              Conten:Conten
                           TopicType:TopicType
                                Tags:Tags
                           ChapterID:ChapterID
                              Source:Source
                            SourceID:SourceID
                            finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)deleteForumTypeWithForumTypeID:(long)ForumTypeID
                                  OCID:(long)OCID
                              finished:(FinishedBlock)finished {
    [BbsAction deleteForumTypeWithForumTypeID:ForumTypeID
                                         OCID:OCID
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getOCClassDropdownListWithOCID:(long)OCID
                              finished:(FinishedBlock)finished {
    [BbsAction getOCClassDropdownListWithOCID:OCID
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)updateForumMyIsGoodWithTopicID:(long)TopicID
                            ResponseID:(long)ResponseID
                              finished:(FinishedBlock)finished {
    [BbsAction updateForumMyIsGoodWithTopicID:TopicID
                                   ResponseID:ResponseID
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)deleteForumTopicwithTopicID:(long)TopicID
                           finished:(FinishedBlock)finished {
    [BbsAction deleteForumTopicwithTopicID:TopicID
                                  finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)deleteForumResponseWithResponseID:(long)ResponseID
                                 finished:(FinishedBlock)finished {
    [BbsAction deleteForumResponseWithResponseID:ResponseID
                                        finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getAppChapterzhangListWithOCID:(long)OCID
                              finished:(FinishedBlock)finished {
    [BbsAction getAppChapterzhangListWithOCID:OCID
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)setAppForumTopicIsTopWithTopicID:(long)TopicID
                                finished:(FinishedBlock)finished {
    [BbsAction setAppForumTopicIsTopWithTopicID:TopicID
                                       finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)setAppForumTopicIsEssenceWithTopicID:(long)TopicID
                                    finished:(FinishedBlock)finished {
    [BbsAction setAppForumTopicIsEssenceWithTopicID:TopicID
                                           finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)addAppForumTopicTypeWithTopicID:(long)TopicID
                            ForumTypeID:(NSString *)ForumTypeID
                               finished:(FinishedBlock)finished {
    [BbsAction addAppForumTopicTypeWithTopicID:TopicID
                                   ForumTypeID:ForumTypeID
                                      finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}



- (void)getAppTestNotSumbitListWithOCID:(long)OCID
                               finished:(FinishedBlock)finished {
    [TestAtion getAppTestNotSumbitListWithOCID:OCID
                                      finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
}

- (void)getAppTestInfoSumbitListWithOCID:(long)OCID
                                finished:(FinishedBlock)finished {
    [TestAtion getAppTestInfoSumbitListWithOCID:OCID
                                       finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
}

- (void)addAppOCAffairsWithOCID:(long)OCID
                           Type:(int)Type
                         TestID:(long)TestID
                          Reson:(NSString *)Reson
                       finished:(FinishedBlock)finished {
    [TestAtion addAppOCAffairsWithOCID:OCID
                                  Type:Type
                                TestID:TestID
                                 Reson:Reson
                              finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
}

- (void)TestCanSeeTestWithTestID:(long)TestID
                        finished:(FinishedBlock)finished {
    [TestAtion TestCanSeeTestWithTestID:TestID
                               finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
}

- (void)getPaperInfoWithPaperID:(long)PaperID
                         TestID:(long)TestID
                       finished:(FinishedBlock)finished {
    [TestAtion getPaperInfoWithPaperID:PaperID
                                TestID:TestID
                              finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
}

- (void)getTestAnswerWithTestID:(long)TestID
                       finished:(FinishedBlock)finished {
    [TestAtion getTestAnswerWithTestID:TestID
                              finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
}

- (void)saveTestTempwithTestID:(long)TestID
                        Answer:(NSString *)Answer
                      finished:(FinishedBlock)finished {
    [TestAtion saveTestTempwithTestID:TestID
                               Answer:Answer
                             finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
}

- (void)SubmitTestWithTestID:(long)TestID
                      Answer:(NSString *)Answer
                    finished:(FinishedBlock)finished {
    [TestAtion SubmitTestWithTestID:TestID
                             Answer:Answer
                           finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
}

- (void)updateTestUserStatusWithUserID:(long)UserID
                                TestID:(long)TestID
                                Status:(int)Status
                              finished:(FinishedBlock)finished {
    [TestAtion updateTestUserStatusWithUserID:UserID
                                       TestID:TestID
                                       Status:Status
                                     finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
}
- (void)getTestListwithOCID:(long)OCID
                       Type:(int)Type
                  PageIndex:(int)PageIndex
                   PageSize:(int)PageSize
                   finished:(FinishedBlock)finished {
    [TestAtion getTestListwithOCID:OCID
                              Type:Type
                         PageIndex:PageIndex
                          PageSize:PageSize
                          finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
}

- (void)getTestUserListWithTestID:(long)TestID
                        PageIndex:(int)PageIndex
                         PageSize:(int)PageSize
                         finished:(FinishedBlock)finished {
    [TestAtion getTestUserListWithTestID:TestID
                               PageIndex:PageIndex
                                PageSize:PageSize
                                finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}


- (void)getAffairsListWithType:(int)Type
                          OCID:(long)OCID
                     IsHistory:(int)IsHistory
                     PageIndex:(int)PageIndex
                      PageSize:(int)PageSize
                      finished:(FinishedBlock)finished {
    
    [AffairsAction getAffairsListWithType:Type
                                     OCID:OCID
                                IsHistory:IsHistory
                                PageIndex:PageIndex
                                 PageSize:PageSize
                                 finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)updateOCAffairsStatusWithAffairID:(long)AffairID Status:(int)Status finished:(FinishedBlock)finished {
    [AffairsAction updateOCAffairsStatusWithAffairID:AffairID
                                              Status:Status
                                            finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getSurveyMyJoinListWithKey:(NSString *)Key
                              OCID:(long)OCID
                          finished:(FinishedBlock)finished{
    [SurveyAction getSurveyMyJoinListWithKey:Key
                                        OCID:OCID
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

- (void)getSurveyToObjectWithSurveyID:(long)SurveyID
                             finished:(FinishedBlock)finished {
    [SurveyAction getSurveyToObjectWithSurveyID:SurveyID
                                       finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
}

- (void)getSurveyInfoWithSurveyID:(long)SurveyID
                         finished:(FinishedBlock)finished {
    [SurveyAction getSurveyInfoWithSurveyID:SurveyID
                                   finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
}

- (void)getSurveyAnswerWithSurveyID:(long)SurveyID
                           ObjectID:(long)ObjectID
                           finished:(FinishedBlock)finished {
    [SurveyAction getSurveyAnswerWithSurveyID:SurveyID
                                     ObjectID:ObjectID
                                     finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
}

- (void)getSurveyAnswerInfoWithSurveyID:(long)SurveyID
                               finished:(FinishedBlock)finished {
    [SurveyAction getSurveyInfoWithSurveyID:SurveyID
                                   finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
}


- (void)editSurveyAnswerwithSurveyID:(long)SurveyID
                              Conten:(NSString *)Conten
                              Status:(int)Status
                            ObjectID:(long)ObjectID
                            finished:(FinishedBlock)finished {
    [SurveyAction editSurveyAnswerwithSurveyID:SurveyID
                                        Conten:Conten
                                        Status:Status
                                      ObjectID:ObjectID
                                      finished:^(EnumServerStatus status, NSObject *object) {
         finished(status, object);
    }];
}




@end
