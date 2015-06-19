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

@end
