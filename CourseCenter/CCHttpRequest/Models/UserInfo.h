//
//  UserInfo.h
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KUserID                         @"UserID"
#define KUserType                       @"UserType"
#define KUserNo                         @"UserNo"
#define KUserName                       @"UserName"
#define KGender                         @"Gender"
#define KUserImg                        @"UserImg"
#define kRole                           @"Role"
#define kIsStudent                      @"IsStudent"
#define kProgress                       @"Progress"
#define kTestID                                 @"TestID"
#define kClassName                              @"ClassName"
#define kStatus                                 @"Status"
#define kFastScore                              @"FastScore"

@interface UserInfo : NSObject

    //用户ID
@property(nonatomic, assign) long       userID;
@property(nonatomic, assign) int        userType;
@property(nonatomic, strong) NSString   *userNo;
    //姓名
@property(nonatomic, strong) NSString   *userName;
@property(nonatomic, assign) int        gender;
@property(nonatomic, strong) NSString   *userImg;
    //身份（1教师2学生）
@property(nonatomic, strong) NSString *Role;
    ///是否学生
@property(nonatomic, assign) BOOL IsStudent;
    ///进度
@property(nonatomic, assign) float Progress;

@property(nonatomic, assign) long TestID;
    ///班级名称
@property(nonatomic, strong) NSString *ClassName;
    ///作业状态
@property(nonatomic, assign) int Status;
    ///得分
@property(nonatomic, assign) int FastScore;

- (id)initWithDict:(NSDictionary *)dict;

@end
