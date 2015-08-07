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

@end
