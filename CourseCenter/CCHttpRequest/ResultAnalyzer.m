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
#import "FRankInfo.h"
#import "OCFCLearnNavInfo.h"
#import "FCourseDetailInfo.h"
#import "OCFCFileInfo.h"
#import "TestInfo.h"
#import "LiveForumInfo.h"
#import "FCOfflineInfo.h"

#define Kresult             @"result"

@implementation ResultAnalyzer

+ (ResponseObject *)analyseResult:(NSDictionary *)resultObject
                     connecteFlag:(NSString *)flag {
    ResponseObject *responseObject = [[ResponseObject alloc] initWithDict:resultObject];
    responseObject.message = responseObject.errorMessage;
    if ([flag isEqualToString:KLogin]) {
        UserInfo *user = [[UserInfo alloc] initWithDict:[resultObject objectForKey:Kresult]];
        if ([responseObject.errrorCode isEqualToString:KSuccess]) {
            responseObject.message = @"登录成功";
        }
        responseObject.resultObject = user;
    } else if ([flag isEqualToString:kLogout]) {
        
    } else if ([flag isEqualToString:kgetUserInfo]) {
        UserInfo *user = [[UserInfo alloc] initWithDict:[resultObject objectForKey:Kresult]];
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
    }else if ([flag isEqualToString:kOCMoocStuFile_Add]) {
        if ([responseObject.errrorCode isEqualToString:KSuccess]) {
            responseObject.message = @"提交成功";
        }
    }else if ([flag isEqualToString:kOCMoocStuFile_TimeCount]) {
        if ([responseObject.errrorCode isEqualToString:KSuccess]) {
            responseObject.message = @"提交成功";
        }
    }else if ([flag isEqualToString:kOCMoocStuFile_StudyTimes]) {
        if ([responseObject.errrorCode isEqualToString:KSuccess]) {
            responseObject.message = @"提交成功";
        }
    }else if ([flag isEqualToString:kOCMoocStuFile_Seconds]) {
        if ([responseObject.errrorCode isEqualToString:KSuccess]) {
            responseObject.message = @"提交成功";
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
                UserInfo *user = [[UserInfo alloc] initWithDict:array[i]];
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
                UserInfo *user = [[UserInfo alloc] initWithDict:array[i]];
                [results addObject:user];
            }
            responseObject.resultArray = results;
        }
        
    } else if ([flag isEqualToString:kApp_OCFCScoreRank_Get])
    {
        if (![resultObject[Kresult] isKindOfClass:[NSNull class]]) {
            FRankInfo *frank = [[FRankInfo alloc] initWithDict:resultObject[Kresult]];
            responseObject.resultObject = frank;
        }
    } else if ([flag isEqualToString:kOCFC_LearnNavInfo_Get])
    {
        if (![resultObject[Kresult] isKindOfClass:[NSNull class]]) {
            OCFCLearnNavInfo *learnNav =(OCFCLearnNavInfo *) [[OCFCLearnNavInfo alloc] initWithDict:resultObject[Kresult]];
            responseObject.resultObject = learnNav;
        }
    } else if ([flag isEqualToString:kApp_OCFC_Get]) {
        if (![resultObject[Kresult] isKindOfClass:[NSNull class]]) {
            FCourseDetailInfo *fcourseDetail = [[FCourseDetailInfo alloc] initWithDict:resultObject[Kresult]];
            responseObject.resultObject = fcourseDetail;
        }
    } else if ([flag isEqualToString:kOCFCFile_List]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                 OCFCFileInfo*file = [[OCFCFileInfo alloc] initWithDict:array[i]];
                [results addObject:file];
            }
            responseObject.resultArray = results;
        }
        
    } else if ([flag isEqualToString:kOCFCLiveTest_List]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                TestInfo *test = [[TestInfo alloc] initWithDict:array[i]];
                [results addObject:test];
            }
            responseObject.resultArray = results;
        }
        
    } else if ([flag isEqualToString:kOCFCLiveForum_List]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                LiveForumInfo *liveForum = [[LiveForumInfo alloc] initWithDict:array[i]];
                [results addObject:liveForum];
            }
            responseObject.resultArray = results;
        }
        
    } else if ([flag isEqualToString:kOCFCOffline_List]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                FCOfflineInfo *fcoffline = [[FCOfflineInfo alloc] initWithDict:array[i]];
                [results addObject:fcoffline];
            }
            responseObject.resultArray = results;
        }
        
    } else if ([flag isEqualToString:kApp_OCFCScore_Group_Get]) {
        id result = [resultObject objectForKey:Kresult];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
        if ([result isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)result;
            for (int i=0; i<array.count; i++) {
                RankInfo *rank = [[RankInfo alloc] initWithDict:array[i]];
                [results addObject:rank];
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

    //字典类型的数据解析
+ (ResponseObject *)analyseResult:(NSDictionary *)resultObject
                    connecteClass:(Class)Class {
    ResponseObject *responseObject = [[ResponseObject alloc] initWithDict:resultObject];
    responseObject.message = responseObject.errorMessage;
    if ([Tool dicContainsKey:resultObject keyValue:Kresult]) {
        id reslut = resultObject[Kresult];
        if ([reslut isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)reslut;
             NSMutableArray *resluts = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i=0; i<array.count; i++) {
                id reslut = [[Class alloc] initWithDict:array[i]];
                [resluts addObject:reslut];
            }
            responseObject.resultArray = resluts;
        } else {
            id reslut = [[Class alloc] initWithDict:resultObject[Kresult]];
            responseObject.resultObject =reslut;
        }
    }
    return responseObject;
}

@end
