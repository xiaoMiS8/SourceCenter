//
//  TestAtion.m
//  CourseCenter
//
//  Created by jian on 15/7/31.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "TestAtion.h"

@implementation TestAtion

+ (void)getAppTestNotSumbitListWithOCID:(long)OCID
                               finished:(FinishedBlock)finished {
    NSDictionary *p = @{kOCID: @(OCID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Test/App_Test_NotSumbit_List"
                                  parameters:p
                                connectClass:[TestInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getAppTestInfoSumbitListWithOCID:(long)OCID
                                finished:(FinishedBlock)finished {
    NSDictionary *p = @{kOCID: @(OCID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Test/App_TestInfo_Sumbit_List"
                                  parameters:p
                                connectClass:[TestInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)addAppOCAffairsWithOCID:(long)OCID
                           Type:(int)Type
                         TestID:(long)TestID
                          Reson:(NSString *)Reson
                       finished:(FinishedBlock)finished {
    NSDictionary *p = @{kOCID:@(OCID),
                        kType: @(Type),
                        kTestID: @(TestID),
                        kReson: Reson};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Test/App_OCAffairs_Add"
                                   parameters:p
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)TestCanSeeTestWithTestID:(long)TestID
                        finished:(FinishedBlock)finished {
    NSDictionary *p = @{kTestID: @(TestID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Test/Test_CanSeeTest"
                                  parameters:p
                                connectClass:Nil
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getPaperInfoWithPaperID:(long)PaperID
                         TestID:(long)TestID
                       finished:(FinishedBlock)finished {
    NSDictionary *p = @{kPaperID: @(PaperID),
                        kTestID: @(TestID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Test/PaperInfo_Get"
                                  parameters:p
                                connectClass:[TestPaperInfo class] finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getTestAnswerWithTestID:(long)TestID
                       finished:(FinishedBlock)finished {
    NSDictionary *p = @{kTestID: @(TestID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Test/TestAnswer_Get"
                                  parameters:p
                                connectClass:[TestAnswerInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)saveTestTempwithTestID:(long)TestID
                        Answer:(NSString *)Answer
                      finished:(FinishedBlock)finished {
    NSDictionary *p = @{kTestID: @(TestID),
                        kAnswer: Answer};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Test/TestTempSave_Upd"
                                   parameters:p
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status,object);
    }];
}

+ (void)SubmitTestWithTestID:(long)TestID
                      Answer:(NSString *)Answer
                    finished:(FinishedBlock)finished {
    NSDictionary *p = @{kTestID: @(TestID),
                        kAnswer: Answer};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Test/Test_Submit"
                                   parameters:p
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
                                         finished(status,object);
                                     }];
    
}

+ (void)updateTestUserStatusWithUserID:(long)UserID
                                TestID:(long)TestID
                                Status:(int)Status
                              finished:(FinishedBlock)finished {
    NSDictionary *p = @{kUserID: @(UserID),
                        kTestID: @(TestID),
                        kStatus: @(Status)};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Test/TestUser_Status_Upd"
                                   parameters:p
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(Status, object);
    }];
    
}
+ (void)getTestListwithOCID:(long)OCID
                       Type:(int)Type
                  PageIndex:(int)PageIndex
                   PageSize:(int)PageSize
                   finished:(FinishedBlock)finished {
    NSDictionary *p = @{kOCID: @(OCID),
                        kType: @(Type),
                        kPageIndex: @(PageIndex),
                        kPageSize: @(PageSize)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Test/Test_List"
                                  parameters:p
                                connectClass:[TestInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getTestUserListWithTestID:(long)TestID
                        PageIndex:(int)PageIndex
                         PageSize:(int)PageSize
                         finished:(FinishedBlock)finished {
    NSDictionary *p = @{kTestID: @(TestID),
                        kPageIndex: @(PageIndex),
                        kPageSize: @(PageSize)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Test/TestUser_List"
                                  parameters:p
                                connectClass:[UserInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

@end
