//
//  UserActions.h
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetAccessor.h"

#define KloginName          @"LoginName"
#define KPwd                @"Pwd"


@interface UserActions : NSObject

/**
 *   登录
 *
 *  @param loginName 用户名
 *  @param pwd       密码
 *  @param finished  finished 
 */
+ (void)loginWithLoginName:(NSString *)loginName
                       Pwd:(NSString *)pwd
                  finished:(FinishedBlock)finished;

@end
