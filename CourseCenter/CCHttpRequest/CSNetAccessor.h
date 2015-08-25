//
//  CSNetAccessor.h
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyStrings.h"
#import "ServerConfig.h"
    //连接状态
typedef enum {
        ///返回数据正确
    Enum_SUCCESS = 0,
        ///返回数据出错
    Enum_FAIL = 1,
        ///连接不上服务器
    Enum_NOTCONNECTED = 2,
        ///超时连接
    Enum_CONNECTEDTIMEOUT = 3
} EnumServerStatus;

typedef void (^FinishedBlock)(EnumServerStatus status,NSObject *object);

@interface CSNetAccessor : NSObject

    ///发送一个post异步请求
+ (void)sendPostAsyncObjectFormUrl:(NSString *)urlStr
                    parameters:(id)parameters
                   connectFlag:(NSString *)flag
                      finished:(FinishedBlock)finished;
    ///发送一个get异步请求
+ (void)sendGetAsyncObjectFormUrl:(NSString *)urlStr
                        parameters:(id)parameters
                       connectFlag:(NSString *)flag
                          finished:(FinishedBlock)finished;

    ///发送一个post异步请求
+ (void)sendPostAsyncObjectFormUrl:(NSString *)urlStr
                        parameters:(id)parameters
                       connectClass:(Class)Class
                          finished:(FinishedBlock)finished;
    ///发送一个get异步请求
+ (void)sendGetAsyncObjectFormUrl:(NSString *)urlStr
                       parameters:(id)parameters
                      connectClass:(Class)Class
                         finished:(FinishedBlock)finished;
///发送一个post异步请求
+ (void)sendPostAsyncObjectFormExtraUrl:(NSString *)urlStr
                        parameters:(id)parameters
                       connectFlag:(NSString *)flag
                          finished:(FinishedBlock)finished;
@end
