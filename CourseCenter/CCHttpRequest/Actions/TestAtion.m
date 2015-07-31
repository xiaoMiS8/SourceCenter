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

@end
