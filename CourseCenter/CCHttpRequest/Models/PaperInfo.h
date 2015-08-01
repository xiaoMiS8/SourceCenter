//
//  PaperInfo.h
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KPaperID                    @"PaperID"
#define kCourseID                   @"CourseID"
#define kOCID                       @"OCID"
#define kOwnerUserID                @"OwnerUserID"
#define kCreateUserID               @"CreateUserID"
#define kUserName                   @"UserName"
#define kPapername                  @"Papername"
#define kType                       @"Type"
#define kScope                      @"Scope"
#define kShareScope                 @"ShareScope"
#define kTimeLimit                  @"TimeLimit"
#define kBrief                      @"Brief"
#define kUpdateTime                 @"UpdateTime"
#define kNum                        @"Num"
#define kScore                      @"Score"
#define kConten                     @"Conten"
#define kAnswer                     @"Answer"


@interface PaperInfo : NSObject

    ///试卷ID
@property(nonatomic, assign) long PaperID;
    ///课程ID
@property(nonatomic, assign) long CourseID;
    ///在线课程ID
@property(nonatomic, assign) long OCID;
    ///所有者ID
@property(nonatomic, assign) long OwnerUserID;
    ///创建者ID
@property(nonatomic, assign) long CreateUserID;
    ///创建人姓名
@property(nonatomic, strong) NSString *UserName;
    ///试卷名称
@property(nonatomic, strong) NSString *Papername;
    ///试卷类型
@property(nonatomic, assign) int Type;
    ///1
@property(nonatomic, assign) int Scope;
    ///公开范围
@property(nonatomic, assign) int ShareScope;
    ///试卷时长
@property(nonatomic, assign) int TimeLimit;
    ///介绍
@property(nonatomic, strong) NSString *Brief;
    ///最后更新试卷
@property(nonatomic, strong) NSString *UpdateTime;
    ///总题数
@property(nonatomic, assign) int Num;
    ///总分
@property(nonatomic, assign) int Score;
    ///自测型试卷内容
@property(nonatomic, strong) NSString *Conten;
    ///自测型试卷答案
@property(nonatomic, strong) NSString *Answer;

- (id)initWithDict:(NSDictionary *)dict;

@end

