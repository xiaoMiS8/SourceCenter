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
    [UserActions loginWithLoginName:loginName Pwd:pwd finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

@end
