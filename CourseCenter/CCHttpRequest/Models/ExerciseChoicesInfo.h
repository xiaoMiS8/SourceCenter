//
//  ExerciseChoicesInfo.h
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kChoiceID           @"ChoiceID"
#define kExerciseID         @"ExerciseID"
#define kConten             @"Conten"
#define kIsCorrect          @"IsCorrect"
#define kGrou               @"Grou"
#define kOrderNum           @"OrderNum"

@interface ExerciseChoicesInfo : NSObject

    ///选项ID
@property(nonatomic, assign) long ChoiceID;
    ///题目ID
@property(nonatomic, assign) long ExerciseID;
    ///选项内容
@property(nonatomic, strong) NSString *Conten;
    ///是否正确选项
@property(nonatomic, assign) BOOL IsCorrect;
    ///连线题分组用
@property(nonatomic, strong) NSString *Grou;
    ///排序题，排序值
@property(nonatomic, assign) int OrderNum;

- (id)initWithDict:(NSDictionary *)dict;

@end

