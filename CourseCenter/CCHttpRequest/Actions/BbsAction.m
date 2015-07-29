//
//  BbsAction.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/29.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BbsAction.h"

@implementation BbsAction

+ (void)getAppForumTopicListWithOCID:(long)OCID
                         ForumTypeID:(long)ForumTypeID
                           IsEssence:(BOOL)IsEssence
                           IsMyStart:(BOOL)IsMyStart
                            IsMyJoin:(BOOL)IsMyJoin
                           SearchKey:(NSString *)SearchKey
                           PageIndex:(int)PageIndex
                            PageSize:(int)PageSize
                            finished:(FinishedBlock)finished {
    NSDictionary *parameters = nil;
    if (SearchKey) {
        parameters = @{kOCID: @(OCID),
                                     kForumTypeID: @(ForumTypeID),
                                     kIsEssence: [NSNumber numberWithBool:IsEssence],
                                     kIsMyStart: [NSNumber numberWithBool:IsMyStart],
                                     kIsMyJoin: [NSNumber numberWithBool:IsMyJoin],
                                     kSearchkey: SearchKey,
                                     kPageIndex: @(PageIndex),
                                     kPageSize: @(PageSize)
                                     };
    } else {
        parameters = @{kOCID: @(OCID),
                       kForumTypeID: @(ForumTypeID),
                       kIsEssence: @(IsEssence),
                       kIsMyStart: @(IsMyStart),
                       kIsMyJoin: @(IsMyJoin),
                       kPageIndex: @(PageIndex),
                       kPageSize: @(PageSize)
                       };
    }

    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Forum/App_ForumTopic_List" parameters:parameters connectClass:[TopicInfo class] finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getAppForumTopicWithTopicID:(long)TopicID
                           finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kTopicID: @(TopicID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Forum/App_ForumTopic_Get"
                                  parameters:parameters
                                connectClass:[TopicInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getAppForumResponseInfoListWithTopicID:(long)TopicID
                                      finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kTopicID: @(TopicID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Forum/App_ForumResponseInfo_List"
                                  parameters:parameters
                                connectClass:[TopicInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
                                        finished(status, object);
                                    }];
}

@end
