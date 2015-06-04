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
@interface UserInfo : NSObject

@property(nonatomic, assign) long       userID;
@property(nonatomic, assign) int        userType;
@property(nonatomic, strong) NSString   *userNo;
@property(nonatomic, strong) NSString   *userName;
@property(nonatomic, assign) int        gender;
@property(nonatomic, strong) NSString   *userImg;

- (id)initDict:(NSDictionary *)dict;

@end
