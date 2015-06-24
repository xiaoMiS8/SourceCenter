//
//  ResultAnalyzer.m
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "ResultAnalyzer.h"
#import "UserInfo.h"
#import "OCourseInfo.h"
#import "SpecialtyTypeInfo.h"
#import "TeacherInfo.h"
#import "ChapterInfo.h"
#import "MoocFileInfo.h"

#define Kresult             @"result"

@implementation ResultAnalyzer

+ (ResponseObject *)analyseResult:(NSDictionary *)resultObject
                     connecteFlag:(NSString *)flag {
    ResponseObject *responseObject = [[ResponseObject alloc] initWithDict:resultObject];
    responseObject.message = responseObject.errorMessage;
    if ([flag isEqualToString:KLogin]) {
        UserInfo *user = [[UserInfo alloc] initDict:[resultObject objectForKey:Kresult]];
        if ([responseObject.errrorCode isEqualToString:KSuccess]) {
            responseObject.message = @"登录成功";
        }
        responseObject.resultObject = user;
    } else if ([flag isEqualToString:kLogout]) {
        
    } else if ([flag isEqualToString:kgetUserInfo]) {
        UserInfo *user = [[UserInfo alloc] initDict:[resultObject objectForKey:Kresult]];
        responseObject.resultObject = user;
    } else if ([flag isEqualToString:kRecommendCourse_List] ||
               [flag isEqualToString:kOC_All_List]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                OCourse *ocourse = [[OCourse alloc] initWithDict:array[i]];
                [results addObject:ocourse];
            }
            responseObject.resultArray = results;
        }
    } else if ([flag isEqualToString:kSpecialtyType_Tree]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                SpecialtyTypeInfo *specialtyType = [[SpecialtyTypeInfo alloc] initWithDict:array[i]];
                [results addObject:specialtyType];
            }
            responseObject.resultArray = results;
        }
    } else if ([flag isEqualToString:kApp_OCMooc_Get]) {

        TeacherInfo *teacher = [[TeacherInfo alloc] initWithDict:[resultObject objectForKey:Kresult]];
        responseObject.resultObject = teacher;
    } else if ([flag isEqualToString:kChapterStudy_List]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                ChapterInfo *chapter = [[ChapterInfo alloc] initWithDict:array[i]];
                [results addObject:chapter];
            }
            responseObject.resultArray = results;
        }
        
    } else if ([flag isEqualToString:kOCMoocFileStudy_List]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                MoocFileInfo *moocFile = [[MoocFileInfo alloc] initWithDict:array[i]];
                [results addObject:moocFile];
            }
            responseObject.resultArray = results;
        }
    }
    
    return responseObject;
}

+ (ResponseObject *)analyseResultObject:(NSString *)resultString
                           connecteFlag:(NSString *)flag {
    return nil;
}

@end
