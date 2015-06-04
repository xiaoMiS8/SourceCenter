//
//  ResultAnalyzer.h
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyStrings.h"
#import "ResponseObject.h"

#define KSuccess            @"0"

@interface ResultAnalyzer : NSObject

+ (ResponseObject *)analyseResult:(NSDictionary *)resultObject connecteFlag:(NSString *)flag;
+ (ResponseObject *)analyseResultObject:(NSString *)resultString connecteFlag:(NSString *)flag;

@end
