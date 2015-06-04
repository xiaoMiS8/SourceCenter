//
//  UserActions.m
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "UserActions.h"

@implementation UserActions

+ (void)loginWithLoginName:(NSString *)loginName
                       Pwd:(NSString *)pwd
                  finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{KloginName: loginName,
                                 KPwd: pwd};
    [CSNetAccessor sendAsyncObjectFormUrl:@"/User/Login" parameters:parameters connectFlag:KLogin finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

@end
