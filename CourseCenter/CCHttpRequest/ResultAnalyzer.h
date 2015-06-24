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

    //字典类型的数据解析
+ (ResponseObject *)analyseResult:(NSDictionary *)resultObject
                     connecteFlag:(NSString *)flag;
    //非字典类型的数据解析
+ (ResponseObject *)analyseResultObject:(NSString *)resultString
                           connecteFlag:(NSString *)flag;

@end
