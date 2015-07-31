//
//  TestUserNotCheckInfo.h
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestUserNotCheckInfo : NSObject

    ///作业ID
@property(nonatomic, assign) long TestID;
    ///标题
@property(nonatomic, strong) NSString *TestName;
    ///提交时间
@property(nonatomic, strong) NSString *SubmitTime;
    ///用户ID
@property(nonatomic, assign) long UserID;
    ///学号/教工号
@property(nonatomic, strong) NSString *UserNo;
    ///姓名
@property(nonatomic, strong) NSString *UserName;
    ///专业名称
@property(nonatomic, strong) NSString *SpecialtyName;
    ///班级名称
@property(nonatomic, strong) NSString *ClassName;
    ///试卷类型
@property(nonatomic, assign) int BuildMode;

@end
