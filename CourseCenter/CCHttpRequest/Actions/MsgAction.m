//
//  MsgAction.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/14.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MsgAction.h"

@implementation MsgAction

+ (void)getAppUnReadMessageCountWithfinished:(FinishedBlock)finished {
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Msg/App_UnReadMessageCount_get" parameters:nil connectFlag:kApp_UnReadMessageCount_get finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getAppMessageListWithkey:(NSString *)key
                       PageIndex:(int)PageIndex
                        PageSize:(int)PageSize finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kkey: key,
                                 kPageIndex: [NSNumber numberWithInt:PageIndex],
                                 kPageSize:[NSNumber numberWithInt:PageSize]};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Msg/App_Message_List"
                                  parameters:parameters
                                 connectFlag:kApp_Message_List
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getAppMessageWithUserID:(long)UserID
                       finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kUserID: [NSNumber numberWithLong:UserID]};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Msg/App_Message_Get"
                                  parameters:parameters
                                 connectFlag:kApp_Message_Get
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)addAppMessageWithTitle:(NSString *)Title
                        Conten:(NSString *)Conten
                ReceiveUserIDs:(NSArray *)ReceiveUserIDs
                      finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kTitle:Title,
                                 kConten: Conten,
                                 kReceiveUserIDs:ReceiveUserIDs};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Msg/App_Message_Add" parameters:parameters connectFlag:kApp_Message_Add finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getOCClassListWithfinished:(FinishedBlock)finished {
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Msg/App_OCClass_List"
                                  parameters:nil
                                 connectFlag:kApp_OCClass_List finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

@end
