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
#import "NoticeInfo.h"
#import "TeachingClassInfo.h"
#import "MsgInfo.h"
#import "GroupInfo.h"
#import "FileInfo.h"
#import "FCourseInfo.h"
#import "CGroupInfo.h"

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
                OCourseInfo *ocourseInfo = [[OCourseInfo alloc] initWithDict:array[i]];
                [results addObject:ocourseInfo];
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
    } else if ([flag isEqualToString:kNoticeInfo_List]) {
            id result = [resultObject objectForKey:Kresult];
            NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
            if ([result isKindOfClass:[NSArray class]]) {
                NSArray *array = (NSArray *)result;
                for (int i=0; i<array.count; i++) {
                    NoticeInfo *noticeInfo = [[NoticeInfo alloc] initWithDict:array[i]];
                    [results addObject:noticeInfo];
                }
                responseObject.resultArray = results;
            }
    } else if ([flag isEqualToString:kNoticeResponse_List]) {
            id result = [resultObject objectForKey:Kresult];
            NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
            if ([result isKindOfClass:[NSArray class]]) {
                NSArray *array = (NSArray *)result;
                for (int i=0; i<array.count; i++) {
                    NoticeResponseInfo *noticeResInfo = [[NoticeResponseInfo alloc] initWithDict:array[i]];
                    [results addObject:noticeResInfo];
                }
                responseObject.resultArray = results;
            }
    } else if ([flag isEqualToString:kApp_TeacherOCClass_List]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                TeachingClassInfo *teachingclassInfo = [[TeachingClassInfo alloc] initWithDict:array[i]];
                [results addObject:teachingclassInfo];
            }
            responseObject.resultArray = results;
        }

    } else if ([flag isEqualToString:kApp_OC_List]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                OCourseInfo *ocoureInfo = [[OCourseInfo alloc] initWithDict:array[i]];
                [results addObject:ocoureInfo];
            }
            responseObject.resultArray = results;
        }
        
    } else if ([flag isEqualToString:kApp_UnReadMessageCount_get]) {
        id result = [resultObject objectForKey:Kresult];
        MsgInfo *msg = [[MsgInfo alloc] init];
        if ([result isKindOfClass:[NSNumber class]]) {
            msg.UnReadCount = [result intValue];
        }
        responseObject.resultObject = msg;
        
    } else if ([flag isEqualToString:kApp_Message_List]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                MsgInfo *msg = [[MsgInfo alloc] initWithDict:array[i]];
                [results addObject:msg];
            }
            responseObject.resultArray = results;
        }
    } else if ([flag isEqualToString:kApp_Message_Get]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
             MsgInfo *msg = [[MsgInfo alloc] initWithDict:array[i]];
            [results addObject:msg];
            }
            responseObject.resultArray = results;
        }
        
    } else if ([flag isEqualToString:kApp_OCClass_List]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                GroupInfo *group = [[GroupInfo alloc] initWithDict:array[i]];
                [results addObject:group];
            }
            responseObject.resultArray = results;
        }

        
    } else if ([flag isEqualToString:kApp_ClassUser_List]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                UserInfo *user = [[UserInfo alloc] initDict:array[i]];
                [results addObject:user];
            }
            responseObject.resultArray = results;
        }
        

    }  else if ([flag isEqualToString:kApp_FileCount_Get]) {
        FileInfo *file = [[FileInfo alloc] initWithDict:resultObject[Kresult]];
        responseObject.resultObject = file;
        
    } else if ([flag isEqualToString:kApp_OCName_List]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                OCourseInfo *occourse = [[OCourseInfo alloc] initWithDict:array[i]];
                [results addObject:occourse];
            }
            responseObject.resultArray = results;
        }
        
    } else if ([flag isEqualToString:kApp_File_Search]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                FileInfo *file = [[FileInfo alloc] initWithDict:array[i]];
                [results addObject:file];
            }
            responseObject.resultArray = results;
        }
        
    } else if ([flag isEqualToString:kApp_OCFC_List]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                FCourseInfo *fcourse = [[FCourseInfo alloc] initWithDict:array[i]];
                [results addObject:fcourse];
            }
            responseObject.resultArray = results;
        }

    } else if ([flag isEqualToString:kApp_FCGroup_Get]) {
        if (![resultObject[Kresult] isKindOfClass:[NSNull class]]) {
            CGroupInfo *cgroup = [[CGroupInfo alloc] initWithDict:resultObject[Kresult]];
            responseObject.resultObject = cgroup;
        }
    } else if ([flag isEqualToString:kApp_FCGroupUser_List]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                UserInfo *user = [[UserInfo alloc] initDict:array[i]];
                [results addObject:user];
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
