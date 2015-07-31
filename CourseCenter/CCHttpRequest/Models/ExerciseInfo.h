//
//  ExerciseInfo.h
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPaperExerciseID            @"PaperExerciseID"
#define kPaperID                    @"PaperID"
#define kPaperGroupID               @"PaperGroupID"
#define kExerciseID                 @"ExerciseID"
#define kParentExerciseID           @"ParentExerciseID"
#define kPaperTacticID              @"PaperTacticID"
#define kConten                     @"Conten"
#define kKens                       @"Kens"
#define kKeys                       @"Keys"
#define kDiffcult                   @"Diffcult"
#define kIsRand                     @"IsRand"
#define kExerciseTypeName           @"ExerciseTypeName"
#define kExerciseType               @"ExerciseType"
#define kScore                      @"Score"
#define kOrde                       @"Orde"
#define kAnswer                     @"Answer"


@interface ExerciseInfo : NSObject

    ///主键
@property(nonatomic, assign) long PaperExerciseID;
    ///试卷ID
@property(nonatomic, assign) long PaperID;
    ///分组ID
@property(nonatomic, assign) long PaperGroupID;
    ///题目ID
@property(nonatomic, assign) long ExerciseID;
    ///组合题父题ID
@property(nonatomic, assign) long ParentExerciseID;
    ///组卷策略ID
@property(nonatomic, assign) long PaperTacticID;
    ///习题内容
@property(nonatomic, strong) NSString *Conten;
    ///知识点
@property(nonatomic, strong) NSString *Kens;
    ///关键字
@property(nonatomic, strong) NSString *Keys;
    ///难度系统
@property(nonatomic, assign) float Diffcult;
    ///是否随机
@property(nonatomic, assign) BOOL IsRand;
    ///题型名称
@property(nonatomic, strong) NSString *ExerciseTypeName;
    ///题型
@property(nonatomic, assign) int ExerciseType;
    ///习题分值
@property(nonatomic, assign) float Score;
    ///习题顺序
@property(nonatomic, strong) NSString *Orde;
    ///习题答案
@property(nonatomic, strong) NSString *Answer;


@end

