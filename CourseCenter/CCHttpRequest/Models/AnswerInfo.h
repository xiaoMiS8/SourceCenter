//
//  AnswerInfo.h
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAnswerID               @"AnswerID"
#define kSurveyID               @"SurveyID"
#define kQuestionID             @"QuestionID"
#define kUserID                 @"UserID"
#define kConten                 @"Conten"
#define kQuestionItemID         @"QuestionItemID"
#define kScore                  @"Score"
#define kObjectID               @"ObjectID"
#define kSelectCount            @"SelectCount"

@interface AnswerInfo : NSObject

    ///答案ID
@property(nonatomic, assign) long AnswerID;
    ///问卷ID
@property(nonatomic, assign) long SurveyID;
    ///题目ID
@property(nonatomic, assign) long QuestionID;
    ///用户ID
@property(nonatomic, assign) long UserID;
    ///答案内容
@property(nonatomic, strong) NSString *Conten;
    ///选择题选择项
@property(nonatomic, assign) long QuestionItemID;
    ///分值(/打分题分值)
@property(nonatomic, assign) int Score;
    ///被评对象ID
@property(nonatomic, assign) long ObjectID;
    ///答案数量
@property(nonatomic, assign) int SelectCount;

- (id)initWithDict:(NSDictionary *)dict;

@end

