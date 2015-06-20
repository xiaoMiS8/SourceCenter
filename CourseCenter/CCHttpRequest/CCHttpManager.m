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

@end