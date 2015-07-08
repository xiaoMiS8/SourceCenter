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

@end
