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

- (id)initWithDict:(NSDictionary *)dict;

@end

