//
//  ResultAnalyzer.m
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "ResultAnalyzer.h"
#import "UserInfo.h"
#define Kresult             @"result"

@implementation ResultAnalyzer

+ (ResponseObject *)analyseResult:(NSDictionary *)resultObject
                     connecteFlag:(NSString *)flag {
    ResponseObject *responseObject = [[ResponseObject alloc] initWithDict:resultObject];
    if ([flag isEqualToString:KLogin]) {
        UserInfo *user = [[UserInfo alloc] initDict:[resultObject objectForKey:Kresult]];
        responseObject.message = responseObject.errorMessage;
        if ([responseObject.errrorCode isEqualToString:KSuccess]) {
            responseObject.message = @"登录成功";
        }
        responseObject.resultObject = user;
    }
    return responseObject;
}

+ (ResponseObject *)analyseResultObject:(NSString *)resultString
                           connecteFlag:(NSString *)flag {
    return nil;
}

@end
