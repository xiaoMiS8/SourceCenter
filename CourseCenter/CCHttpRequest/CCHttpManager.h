//
//  CCRequestManager.h
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserActions.h"
@interface CCHttpManager : NSObject
/**
 *  登录
 *
 *  @param loginName 用户名
 *  @param pwd       密码
 *  @param finished  finished
 */
- (void)loginWithLoginName:(NSString *)loginName
                       Pwd:(NSString *)pwd
                  finished:(FinishedBlock)finished;

@end
