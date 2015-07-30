//
//  ForumTypeInfo.h
//  CourseCenter
//
//  Created by rxj on 15/7/30.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kForumTypeID            @"ForumTypeID"
#define kOCID                   @"OCID"
#define kCourseID               @"CourseID"
#define kTitle                  @"Title"
#define kOrde                   @"Orde"
#define kIsEssence              @"IsEssence"
#define kBrief                  @"Brief"
#define kIsPublic               @"IsPublic"
#define kUserID                 @"UserID"
#define kClassName              @"ClassName"
#define kCreateDate             @"CreateDate"
#define kIsSys                  @"IsSys"

@interface ForumTypeInfo : NSObject

    ///论坛版块ID
@property(nonatomic, assign) long ForumTypeID;
    ///在线课程ID
@property(nonatomic, assign) long OCID;
    ///课程ID
@property(nonatomic, assign) long CourseID;
    ///标题
@property(nonatomic, strong) NSString *Title;
    ///排序
@property(nonatomic, strong) NSString *Orde;
    ///是否精华
@property(nonatomic, assign) BOOL IsEssence;
    ///简介
@property(nonatomic, strong) NSString *Brief;
    ///是否公共版块
@property(nonatomic, assign) BOOL IsPublic;
    ///用户ID
@property(nonatomic, assign) long UserID;
    ///班级名称
@property(nonatomic, strong) NSString *ClassName;
    ///创建时间
@property(nonatomic, strong) NSString *CreateDate;
    ///是否系统版块
@property(nonatomic, assign) BOOL IsSys;

- (id)initWithDict:(NSDictionary *)dict;

@end

