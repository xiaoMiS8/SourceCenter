//
//  FCourseInfo.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/27.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "FCourseAction.h"

@implementation FCourseAction

+ (void)getAppOCFCListWithOCID:(long)OCID
                      finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kOCID: [NSNumber numberWithLong:OCID]};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/FC/App_OCFC_List"
                                  parameters:parameters
                                 connectFlag:kApp_OCFC_List
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getAppFCGroupWithOCID:(long)OCID
                         FCID:(long)FCID
                     finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kOCID:[NSNumber numberWithLong:OCID],
                                 kFCID: [NSNumber numberWithLong:FCID]};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/FC/App_FCGroup_Get"
                                  parameters:parameters
                                 connectFlag:kApp_FCGroup_Get
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getAppFCGroupUserListWithOCID:(long)OCID
                                 FCID:(long)FCID
                             finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kOCID:[NSNumber numberWithLong:OCID],
                                 kFCID: [NSNumber numberWithLong:FCID]};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/FC/App_FCGroup_Get"
                                  parameters:parameters
                                 connectFlag:kApp_FCGroupUser_List
                                    finished:^(EnumServerStatus status, NSObject *object) {
                                        finished(status, object);
                                    }];
    
}

+ (void)getAppOCFCScoreRankWithFCID:(long)FCID
                           finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kFCID:@(FCID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/FC/App_OCFCScoreRank_Get"
                                  parameters:parameters
                                 connectFlag:kApp_OCFCScoreRank_Get finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getOCFCLearnNavInfowithOCID:(long)OCID
                               FCID:(long)FCID finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kOCID: @(OCID),
                                 kFCID: @(FCID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/FC/OCFC_LearnNavInfo_Get"
                                  parameters:parameters
                                 connectFlag:kOCFC_LearnNavInfo_Get finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getAppOCFCWithFCID:(long)FCID
                  finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kFCID:@(FCID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"FC/App_OCFC_Get" parameters:parameters connectFlag:kApp_OCFC_Get finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getOCFCFileListWithFCID:(long)FCID
                       finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kFCID:@(FCID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"FC/OCFCFile_List" parameters:parameters connectFlag:kOCFCFile_List finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getOCFCLiveTestListWithFCID:(long)FCID
                           finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kFCID:@(FCID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"FC/OCFCLiveTest_List" parameters:parameters connectFlag:kOCFCLiveTest_List finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getOCFCLiveForumListWithFCID:(long)FCID
                            finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kFCID:@(FCID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"FC/OCFCLiveForum_List" parameters:parameters connectFlag:kOCFCLiveForum_List finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getOCFCOfflineListWithFCID:(long)FCID
                          finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kFCID:@(FCID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"FC/OCFCOffline_List" parameters:parameters connectFlag:kOCFCOffline_List finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getAppOCFCScoreGroupWithFCID:(long)FCID
                            finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kFCID:@(FCID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"FC/App_OCFCScore_Group_Get" parameters:parameters connectFlag:kApp_OCFCScore_Group_Get finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

@end
