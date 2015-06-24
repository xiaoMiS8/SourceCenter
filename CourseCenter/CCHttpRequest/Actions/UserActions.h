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
#define kYpwd               @"Ypwd"
#define kNPwd               @"NPwd"


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
/**
 *  注销
 *
 *  @param finished finished description
 */
+ (void)LogoutWithfinished:(FinishedBlock)finished;

/**
 *  得到个人信息
 *
 *  @param finished finished description
 */
+ (void)getUserInfoWithfinished:(FinishedBlock)finished;

/**
 *  密码修改
 *
 *  @param Ypwd     原始密码
 *  @param NPwd     新密码
 *  @param finished finished description
 */
+ (void)updatePassWordWithYpwd:(NSString *)Ypwd
                          NPwd:(NSString *)NPwd
                      finished:(FinishedBlock)finished;

@end
