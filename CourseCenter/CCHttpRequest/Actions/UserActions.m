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
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/User/Login" parameters:parameters connectFlag:KLogin finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)LogoutWithfinished:(FinishedBlock)finished {
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/User/Logout"
                                   parameters:nil connectFlag:kLogout
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getUserInfoWithfinished:(FinishedBlock)finished {
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/User/User_Get"
                                  parameters:nil connectFlag:kgetUserInfo
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)updatePassWordWithYpwd:(NSString *)Ypwd
                          NPwd:(NSString *)NPwd
                      finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kYpwd: Ypwd,
                                 kNPwd: NPwd};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/User/Pwd_Upd" parameters:parameters connectFlag:kPwd_Upd finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

@end