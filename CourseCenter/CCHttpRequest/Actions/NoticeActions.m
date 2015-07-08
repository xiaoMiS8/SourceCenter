//
//  NoticeActions.m
//  
//
//  Created by jian on 15/6/24.
//
//

#import "NoticeActions.h"

@implementation NoticeActions

+ (void)getNoticeInfoListWithOCID:(long)OCID
                            SysID:(long)SysID
                         ModuleID:(long)ModuleID
                        PageIndex:(int)PageIndex
                         PageSize:(int)PageSize
                         finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kOCID: [NSNumber numberWithLong:OCID],
                                 kSysID: [NSNumber numberWithLong:SysID],
                                 kModuleID: [NSNumber numberWithLong:ModuleID],
                                 kPageSize: [NSNumber numberWithInt:PageIndex],
                                 kPageSize: [NSNumber numberWithInt:PageSize]
                                 };
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Notice/NoticeInfo_List"
                                  parameters:parameters
                                 connectFlag:kNoticeInfo_List
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getNoticeResponseListWithNoticeID:(long)NoticeID
                                PageIndex:(int)PageIndex
                                 PageSize:(int)PageSize
                                 finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kNoticeID: [NSNumber numberWithLong:NoticeID],
                                 kPageIndex: [NSNumber numberWithInt:PageIndex],
                                 kPageSize: [NSNumber numberWithInt:PageSize]
                                 };
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Notice/NoticeResponse_List"
                                  parameters:parameters
                                 connectFlag:kNoticeResponse_List
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)AddAppNoticeWithTitle:(NSString *)Title
                       Conten:(NSString *)Conten
                        IsTop:(BOOL)IsTop
                    IsForMail:(BOOL)IsForMail
                     IsForSMS:(BOOL)IsForSMS
                    SourceIDs:(NSArray *)SourceIDs
                     finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kTitle: Title,
                                 kConten: Conten,
                                 kIsTop: [NSNumber numberWithBool:IsTop],
                                 kIsForMail: [NSNumber numberWithBool:IsForMail],
                                 kIsForSMS: [NSNumber numberWithBool:IsForSMS],
                                 kSourceIDs: SourceIDs};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Notice/App_Notice_Add"
                                   parameters:parameters
                                  connectFlag:kApp_Notice_Add
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)AddNoticeResponseWithNoticeID:(long)NoticeID
                               Conten:(NSString *)Conten
                             finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kNoticeID: [NSNumber numberWithLong:NoticeID],
                                 kConten: Conten};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Notice/NoticeResponse_ADD"
                                   parameters:parameters
                                  connectFlag:kNoticeResponse_ADD
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getAppTeacherOCClass_ListWithKey:(NSString *)Key
                               IsHistroy:(BOOL)IsHistroy
                               PageIndex:(int)PageIndex
                                PageSize:(int)PageSize
                                finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kkey: Key,
                                 kIsHistroy: [NSNumber numberWithBool:IsHistroy],
                                 kPageIndex: [NSNumber numberWithInt:PageIndex],
                                 kPageSize: [NSNumber numberWithInt:PageSize]};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Notice/App_TeacherOCClass_List"
                                  parameters:parameters
                                 connectFlag:kApp_TeacherOCClass_List
                                    finished:^(EnumServerStatus status, NSObject *object) {
                                        finished(status, object);
                                    }];
}

@end
