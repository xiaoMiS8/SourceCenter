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

- (void)getSpecialtyTypeTreeWithParentID:(long)ParentID finished:(FinishedBlock)finished {
    [IndexActions getSpecialtyTypeTreeWithParentID:ParentID
                                          finished:^(EnumServerStatus status, NSObject *object) {
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
                ReceiveUserIDs:(NSArray *)ReceiveUserIDs
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



@end
