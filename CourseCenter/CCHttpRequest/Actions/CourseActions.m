//
//  CourseActions.m
//  CourseCenter
//
//  Created by jian on 15/7/4.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "CourseActions.h"

@implementation CourseActions

+ (void)getAppOCListWithIsHistroy:(int)IsHistroy
                         finished:(FinishedBlock) finished {
    NSDictionary *parameters = @{kIsHistroy: [NSNumber numberWithInt:IsHistroy]};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Course/App_OC_List"
                                  parameters:parameters
                                 connectFlag:kApp_OC_List
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getOCMoocRecruitCanListWithOCID:(long)OCID
                               finished:(FinishedBlock)finished {
    NSDictionary *p = @{kOCID: @(OCID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Course/OCMoocRecruit_Can_List"
                                  parameters:p
                                connectClass:[RecruitInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}
+ (void)jsonOCMoocRecruitClassWithRecruitID:(long)RecruitID
                                   finished:(FinishedBlock)finished {
    NSDictionary *p = @{kRecruitID: @(RecruitID)};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Course/OCMoocRecruitClass_Join"
                                   parameters:p
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}
+ (void)OCRegisterWithRegNum:(NSString *)RegNum
                        OCID:(long)OCID
                    finished:(FinishedBlock)finished {
    NSDictionary *p = @{kOCID: @(OCID),
                        kRegNum: RegNum};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Course/OC_Register"
                                   parameters:p
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
    
}

@end
