//
//  QuestionInfo.h
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kQuestionID                 @"QuestionID"
#define kSurveyID                   @"SurveyID"
#define kType                       @"Type"
#define kConten                     @"Conten"
#define kIsMust                     @"IsMust"
#define kIsRandom                   @"IsRandom"
#define kMinSel                     @"MinSel"
#define kMaxSel                     @"MaxSel"
#define kParentID                   @"ParentID"
 
@interface QuestionInfo : NSObject

    ///题目ID
@property(nonatomic, assign) long QuestionID;
    ///问卷ID
@property(nonatomic, assign) long SurveyID;
    ///题目类型(1.单选题  2多选题   4.打分题  6. 简答题 7 矩阵单选题  8.矩阵多选题  9.矩阵填空题；   10.矩阵打分题 )
@property(nonatomic, assign) int Type;
    ///题目内容
@property(nonatomic, strong) NSString *Conten;
    ///是否必须作答
@property(nonatomic, assign) BOOL IsMust;
    ///选项是否随机
@property(nonatomic, assign) BOOL IsRandom;
    ///最少选择数
@property(nonatomic, assign) int MinSel;
    ///最多选择数
@property(nonatomic, assign) int MaxSel;
    ///0
@property(nonatomic, assign) long ParentID;

- (id)initWithDict:(NSDictionary *)dict;

@end
