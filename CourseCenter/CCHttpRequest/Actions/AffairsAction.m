//
//  AffairsAction.m
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "AffairsAction.h"

@implementation AffairsAction

+ (void)getAffairsListWithType:(int)Type
                          OCID:(long)OCID
                     IsHistory:(int)IsHistory
                     PageIndex:(int)PageIndex
                      PageSize:(int)PageSize
                      finished:(FinishedBlock)finished {
    NSDictionary *p = @{kType: @(Type),
                        kOCID: @(OCID),
                        kIsHistroy: @(IsHistory),
                        kPageIndex: @(PageIndex),
                        kPageSize: @(PageSize)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Affairs/Affairs_List"
                                  parameters:p
                                connectClass:[AffairInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
    
}

+ (void)updateOCAffairsStatusWithAffairID:(long)AffairID Status:(int)Status finished:(FinishedBlock)finished {
    NSDictionary *p = @{kAffairID: @(AffairID),
                        kStatus: @(Status)};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Affairs/OCAffairs_Status_Upd"
                                   parameters:p
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}


@end
