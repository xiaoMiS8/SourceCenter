//
//  FileAction.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/16.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "FileAction.h"

@implementation FileAction
+ (void)getAppFileCountWithOCID:(long)OCID
                       finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kOCID: [NSNumber numberWithLong:OCID]};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/File/App_FileCount_Get"
                                  parameters:parameters
                                 connectFlag:kApp_FileCount_Get
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getAppOCNameListWithrole:(int)role
                       IsHistroy:(BOOL)IsHistroy
                        finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{krole:[NSNumber numberWithInt:role],
                                 kIsHistroy:[NSNumber numberWithBool:IsHistroy]};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/File/App_OCName_List"
                                  parameters:parameters
                                 connectFlag:kApp_OCName_List
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getAppFileSearchwithSearchkey:(NSString *)Searchkey
                                 OCID:(long)OCID
                             FileType:(int)FileType
                            PageIndex:(int)PageIndex
                             PageSize:(int)PageSize
                             finished:(FinishedBlock)finished {
    NSDictionary *parameters = nil;
    if (Searchkey) {
        parameters = @{kSearchkey: Searchkey,
                       kOCID: [NSNumber numberWithLong:OCID],
                       kFileType: [NSNumber numberWithInt:FileType],
                       kPageIndex: [NSNumber numberWithInt:PageIndex],
                       kPageSize: [NSNumber numberWithInt:PageSize]};
    } else {
        parameters = @{
                       kOCID: [NSNumber numberWithLong:OCID],
                       kFileType: [NSNumber numberWithInt:FileType],
                       kPageIndex: [NSNumber numberWithInt:PageIndex],
                       kPageSize: [NSNumber numberWithInt:PageSize]};
    }
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"File/App_File_Search" parameters:parameters connectFlag:kApp_File_Search finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

@end
