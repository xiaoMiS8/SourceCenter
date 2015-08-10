//
//  TestInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFCLiveID           @"FCLiveID"
#define kTestID             @"TestID"
#define kName               @"Name"
#define kEndDate            @"EndDate"
#define kExerciseCount      @"ExerciseCount"
#define kPaperID            @"PaperID"
#define kType               @"Type"
#define kLiveType           @"LiveType"
#define kBuildMode          @"BuildMode"
#define kFastScore          @"FastScore"
#define kUncommittedCount   @"UncommittedCount"
#define ksubmittedCount     @"submittedCount"
#define kMarkingCount       @"MarkingCount"

@interface TestInfo : NSObject

    ///ID
@property(nonatomic, assign) long FCLiveID;
    ///作业ID
@property(nonatomic, assign) long TestID;
    ///作业名称
@property(nonatomic, strong) NSString *Name;
    ///结束时间
@property(nonatomic, strong) NSString *EndDate;
    ///习题数
@property(nonatomic, assign) int ExerciseCount;
    ///试卷ID
@property(nonatomic, assign) long PaperID;
    ///类型
@property(nonatomic, assign) int Type;
    ///互动的名称
@property(nonatomic, strong) NSString *LiveType;
    ///试卷类型
@property(nonatomic, assign) int BuildMode;
    ///快速设分
@property(nonatomic, strong) NSString * FastScore;
    ///未交数
@property(nonatomic, assign) int UncommittedCount;
    ///待批数
@property(nonatomic, assign) int submittedCount;
    ///批阅数
@property(nonatomic, assign) int MarkingCount;

- (id)initWithDict:(NSDictionary *)dict;

@end

