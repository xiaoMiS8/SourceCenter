//
//  IndexActions.m
//  
//
//  Created by jian on 15/6/19.
//
//

#import "IndexActions.h"

@implementation IndexActions

+ (void)getRecommendCourseListWithfinished:(FinishedBlock)finished {
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Index/RecommendCourse_List"
                                  parameters:nil
                                 connectFlag:kRecommendCourse_List
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getOCAllListWithSpecialtyTypeID:(long)SpecialtyTypeID
                                    key:(NSString *)key
                              PageIndex:(int)PageIndex
                               PageSize:(int)PageSize
                               finished:(FinishedBlock)finished {
    
    NSDictionary *parameters = nil;
    if (!key) {
       parameters = @{
                       kSpecialtyTypeID: [NSNumber numberWithLong:SpecialtyTypeID],
                       kPageIndex: [NSNumber numberWithInt:PageIndex],
                       kPageSize: [NSNumber numberWithInt:PageSize]
                       };
    } else {
        parameters = @{
                       kSpecialtyTypeID: [NSNumber numberWithLong:SpecialtyTypeID],
                       kkey: key,
                       kPageIndex: [NSNumber numberWithInt:PageIndex],
                       kPageSize: [NSNumber numberWithInt:PageSize]
                       };
    }
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Index/OC_All_List" parameters:parameters connectFlag:kOC_All_List finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getSpecialtyTypeTreeWithParentID:(long)ParentID
                                SearchKey:(NSString *)searchKey
                                finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kParentID: [NSNumber numberWithLong:ParentID],kSearchKey:searchKey};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Index/SpecialtyType_Tree"
                                  parameters:parameters
                                 connectFlag:kSpecialtyType_Tree
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getAppOCMoocGetWithOCID:(long)OCID
                         finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kOCID: [NSNumber numberWithLong:OCID]};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Index/App_OCMooc_Get"
                                  parameters:parameters
                                 connectFlag:kApp_OCMooc_Get
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getChapterStudyListwithOCID:(long)OCID
                           finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kOCID: [NSNumber numberWithLong:OCID]};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Index/ChapterStudy_List"
                                  parameters:parameters
                                 connectFlag:kChapterStudy_List
                                    finished:^(EnumServerStatus status, NSObject *object) {
                                        finished(status, object);
                                    }];
}

+ (void)getOCMoocFileStudyListwithOCID:(long)OCID
                              ChapterID:(long)ChapterID
                               FileType:(int)FileType
                               finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{
                                 kOCID: [NSNumber numberWithLong:OCID],
                                 kChapterID: [NSNumber numberWithLong:ChapterID],
                                 kFileType: [NSNumber numberWithInt:FileType]
                                 };
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Index/OCMoocFileStudy_List"
                                  parameters:parameters
                                 connectFlag:kOCMoocFileStudy_List
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)addOCMoocStuFilewithChapterID:(long)ChapterID
                               FileID:(int)FileID
                             IsFinish:(int)IsFinish
                             finished:(FinishedBlock)finished{
    NSDictionary *parameters = @{
                                 kChapterID: [NSNumber numberWithLong:ChapterID],
                                 kFileID: [NSNumber numberWithInt:FileID],
                                 kIsFinish:[NSNumber numberWithInt:IsFinish]
                                 };
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Index/App_OCMoocStuFile_Add"
                                   parameters:parameters
                                   connectFlag:kOCMoocStuFile_Add
                                   finished:^(EnumServerStatus status, NSObject *object) {
                                 finished(status, object);
    }];

}

+ (void)addOCMoocStuFileTimeCountwithChapterID:(long)ChapterID
                                        FileID:(long)FileID
                                     TimeCount:(long)TimeCount
                                      finished:(FinishedBlock)finished{
    NSDictionary *parameters = @{
                                 kChapterID: [NSNumber numberWithLong:ChapterID],
                                 kFileID: [NSNumber numberWithLong:FileID],
                                 kTimeCount:[NSNumber numberWithLong:TimeCount]
                                 };
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Index/OCMoocStuFile_Add"
                                   parameters:parameters
                                  connectFlag:kOCMoocStuFile_TimeCount
                                     finished:^(EnumServerStatus status, NSObject *object) {
                                         finished(status, object);
                                     }];
}

+ (void)addOCMoocStuFileStudyTimeswithChapterID:(long)OCID
                                         FileID:(long)FileID
                                     StudyTimes:(long)StudyTimes
                                       finished:(FinishedBlock)finished{
    NSDictionary *parameters = @{
                                 kOCID: [NSNumber numberWithLong:OCID],
                                 kFileID: [NSNumber numberWithLong:FileID],
                                 kStudyTimes:[NSNumber numberWithLong:StudyTimes]
                                 };
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Index/OCMoocStuFileDesc_Add"
                                   parameters:parameters
                                  connectFlag:kOCMoocStuFile_StudyTimes
                                     finished:^(EnumServerStatus status, NSObject *object) {
                                         finished(status, object);
                                     }];
}

+ (void)addOCMoocStuFileSecondswithChapterID:(long)ChapterID
                                      FileID:(long)FileID
                                     Seconds:(long)Seconds
                                    finished:(FinishedBlock)finished{
    NSDictionary *parameters = @{
                                 kChapterID: [NSNumber numberWithLong:ChapterID],
                                 kFileID: [NSNumber numberWithLong:FileID],
                                 kSeconds:[NSNumber numberWithLong:Seconds]
                                 };
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Index/OCMoocStuFile_StuVideoDesc_Add"
                                   parameters:parameters
                                  connectFlag:kOCMoocStuFile_Seconds
                                     finished:^(EnumServerStatus status, NSObject *object) {
                                         finished(status, object);
                                     }];
}

+ (void)OCMoocStuFilePlayPausewithChapterID:(long)ChapterID
                                     FileID:(long)FileID
                                PlayOrPause:(int)PlayOrPause
                                   finished:(FinishedBlock)finished{
    NSDictionary *parameters = @{
                                 kChapterID: [NSNumber numberWithLong:ChapterID],
                                 kFileID: [NSNumber numberWithLong:FileID],
                                 kPlayOrPause:[NSNumber numberWithLong:PlayOrPause]
                                 };
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Index/App_OCMoocStuFilePlayPause_Set"
                                   parameters:parameters
                                  connectFlag:kOCMoocStuFilePlayPause
                                     finished:^(EnumServerStatus status, NSObject *object) {
                                         finished(status, object);
                                     }];
}
@end
