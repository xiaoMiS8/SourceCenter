//
//  TestAnswerInfo.h
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUserID                 @"UserID"
#define kCheckUserID            @"CheckUserID"
#define kExerciseID             @"ExerciseID"
#define kConten                 @"Conten"
#define kScore                  @"Score"
#define kComment                @"Comment"
#define kExerciseType           @"ExerciseType"
#define kChoiceNum              @"ChoiceNum"
#define kPaperExerciseScore     @"PaperExerciseScore"

@interface TestAnswerInfo : NSObject

    ///答题人ID
@property(nonatomic, assign) long UserID;
    ///批阅人ID
@property(nonatomic, assign) long CheckUserID;
    ///题目ID
@property(nonatomic, assign) long ExerciseID;
    ///题目内容
@property(nonatomic, strong) NSString *Conten;
    ///得分
@property(nonatomic, assign) int Score;
    ///评语
@property(nonatomic, strong) NSString *Comment;
    ///题型
@property(nonatomic, assign) int ExerciseType;
    ///选项数
@property(nonatomic, assign) int ChoiceNum;
    ///答题卡分
@property(nonatomic, assign) int PaperExerciseScore;

- (id)initWithDict:(NSDictionary *)dict;

@end

