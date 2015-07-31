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
                                connectClass:[TopicResponseInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
                                        finished(status, object);
                                    }];
}

+ (void)addForumResponseWithTopicID:(long)TopicID
                           ParentID:(long)ParentID
                             Conten:(NSString *)Conten
                           finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kTopicID: @(TopicID),
                                 kParentID: @(ParentID),
                                 kConten: Conten
                                 };
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Forum/ForumResponse_ADD"
                                   parameters:parameters
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getForumTypeListwithOCID:(long)OCID
                        finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kOCID: @(OCID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Forum/ForumType_List"
                                  parameters:parameters
                                connectClass:[ForumTypeInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)addForumTypeWithOCID:(long)OCID
                    CourseID:(long)CourseID
                       Title:(NSString *)Title
                   IsEssence:(BOOL)IsEssence
                    IsPublic:(BOOL)IsPublic
                       Brief:(NSString *)Brief
             TeachingClassID:(long)TeachingClassID
                       IsSys:(BOOL)IsSys
                    finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kOCID: @(OCID),
                                 kCourseID: @(CourseID),
                                 kTitle: Title,
                                 kIsEssence: @(IsEssence),
                                 kIsPublic: @(IsPublic),
                                 kBrief: Brief,
                                 kTeachingClassID: @(TeachingClassID),
                                 kIsSys: @(IsSys)
                                 };
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Forum/ForumType_ADD"
                                   parameters:parameters
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)updateForumTypeWithOCID:(long)OCID
                       CourseID:(long)CourseID
                          Title:(NSString *)Title
                      IsEssence:(BOOL)IsEssence
                       IsPublic:(BOOL)IsPublic
                          Brief:(NSString *)Brief
                TeachingClassID:(long)TeachingClassID
                          IsSys:(BOOL)IsSys
                       finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kOCID: @(OCID),
                                 kCourseID: @(CourseID),
                                 kTitle: Title,
                                 kIsEssence: @(IsEssence),
                                 kIsPublic: @(IsPublic),
                                 kBrief: Brief,
                                 kTeachingClassID: @(TeachingClassID),
                                 kIsSys: @(IsSys)
                                 };
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Forum/ForumType_Upd"
                                   parameters:parameters
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
                                         finished(status, object);
                                     }];
    
}
+ (void)addForumTopicWithOCID:(long)OCID
                     CourseID:(long)CourseID
                  ForumTypeID:(long)ForumTypeID
                  GroupTaskID:(long)GroupTaskID
                        Title:(NSString *)Title
                       Conten:(NSString *)Conten
                    TopicType:(int)TopicType
                         Tags:(NSArray *)Tags
                    ChapterID:(long)ChapterID
                       Source:(NSString *)Source
                     SourceID:(long)SourceID
                     finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kOCID: @(OCID),
                                 kCourseID: @(CourseID),
                                 kForumTypeID: @(ForumTypeID),
                                 kGroupTaskID: @(GroupTaskID),
                                 kTitle: Title,
                                 kConten: Conten,
                                 kTopicType: @(TopicType),
                                 kTags: Tags,
                                 kChapterID: @(ChapterID),
                                 kSource: Source,
                                 kSourceID: @(SourceID)
                                 };
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Forum/ForumTopic_Add"
                                   parameters:parameters
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
    
}

+ (void)deleteForumTypeWithForumTypeID:(long)ForumTypeID
                                  OCID:(long)OCID
                              finished:(FinishedBlock)finished {
    NSDictionary *parameters = @{kForumTypeID: @(ForumTypeID),
                                 kOCID: @(OCID)
                                 };
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Forum/ForumType_Del"
                                   parameters:parameters
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getOCClassDropdownListWithOCID:(long)OCID
                              finished:(FinishedBlock)finished {
    NSDictionary *p = @{kOCID: @(OCID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Forum/OCClass_Dropdown_List"
                                  parameters:p connectClass:[OCClassInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)updateForumMyIsGoodWithTopicID:(long)TopicID
                            ResponseID:(long)ResponseID
                              finished:(FinishedBlock)finished {
    NSDictionary *p = @{kTopicID: @(TopicID),
                        kResponseID: @(ResponseID)
                        };
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Forum/ForumMy_IsGood_Upd"
                                   parameters:p
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)deleteForumTopicwithTopicID:(long)TopicID
                           finished:(FinishedBlock)finished {
    NSDictionary *p = @{kTopicID: @(TopicID)};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Forum/ForumTopic_Del"
                                   parameters:p
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)deleteForumResponseWithResponseID:(long)ResponseID
                                 finished:(FinishedBlock)finished {
    NSDictionary *p = @{kResponseID: @(ResponseID)};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Forum/ForumResponse_Del"
                                   parameters:p
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getAppChapterzhangListWithOCID:(long)OCID
                              finished:(FinishedBlock)finished {
    NSDictionary *p = @{kOCID: @(OCID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Forum/App_Chapter_zhang_List"
                                   parameters:p
                                 connectClass:[ChapterInfo class]
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)setAppForumTopicIsTopWithTopicID:(long)TopicID
                                finished:(FinishedBlock)finished {
    NSDictionary *p = @{kTopicID: @(TopicID)};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Forum/App_ForumTopic_IsTop_Set"
                                   parameters:p
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)setAppForumTopicIsEssenceWithTopicID:(long)TopicID
                                    finished:(FinishedBlock)finished {
    NSDictionary *p = @{kTopicID: @(TopicID)};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Forum/App_ForumTopic_IsEssence_Set"
                                   parameters:p
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)addAppForumTopicTypeWithTopicID:(long)TopicID
                               finished:(FinishedBlock)finished {
    NSDictionary *p = @{kTopicID: @(TopicID)};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"Forum/App_ForumTopicType_Add"
                                   parameters:p
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

@end
