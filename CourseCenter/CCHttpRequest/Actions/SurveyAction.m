//
//  SurveyAction.m
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "SurveyAction.h"

@implementation SurveyAction

+ (void)getSurveyMyJoinListWithKey:(NSString *)Key
                              OCID:(long)OCID
                          finished:(FinishedBlock)finished {
    NSDictionary *p = @{kkey: Key,
                        kOCID: @(OCID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Survey/Survey_MyJoin_List"
                                  parameters:p
                                connectClass:[SurveyInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
    
}

+ (void)getSurveyToObjectWithSurveyID:(long)SurveyID
                             finished:(FinishedBlock)finished {
    NSDictionary *p = @{kSurveyID: @(SurveyID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Survey/SurveyToObject_Get"
                                  parameters:p
                                connectClass:[ObjectInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
    
}

+ (void)getSurveyInfoWithSurveyID:(long)SurveyID
                         finished:(FinishedBlock)finished {
    NSDictionary *p = @{kSurveyID: @(SurveyID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Survey/SurveyInfo_Get"
                                  parameters:p
                                connectClass:[surveyDetailInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)getSurveyAnswerWithSurveyID:(long)SurveyID
                           ObjectID:(long)ObjectID
                           finished:(FinishedBlock)finished {
    NSDictionary *p = @{kSurveyID: @(SurveyID),
                        kObjectID: @(ObjectID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Survey/SurveyAnswer_Get"
                                  parameters:p
                                connectClass:[AnswerInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
    
}

+ (void)getSurveyAnswerInfoWithSurveyID:(long)SurveyID
                               finished:(FinishedBlock)finished {
    NSDictionary *p = @{kSurveyID: @(SurveyID)};
    [CSNetAccessor sendGetAsyncObjectFormUrl:@"/Survey/SurveyAnswer_Info_Get"
                                  parameters:p
                                connectClass:[SurveyAnswerInfo class]
                                    finished:^(EnumServerStatus status, NSObject *object) {
        finished(status, object);
    }];
}

+ (void)editSurveyAnswerwithSurveyID:(long)SurveyID
                              Conten:(NSString *)Conten
                              Status:(int)Status
                            ObjectID:(long)ObjectID
                            finished:(FinishedBlock)finished {
    NSDictionary *p = @{kSurveyID: @(SurveyID),
                        kConten: Conten,
                        kStatus: @(Status),
                        kObjectID: @(ObjectID)};
    [CSNetAccessor sendPostAsyncObjectFormUrl:@"/Survey/SurveyAnswer_Edit"
                                   parameters:p
                                 connectClass:Nil
                                     finished:^(EnumServerStatus status, NSObject *object) {
        finished(Status, object);
    }];
}

@end
