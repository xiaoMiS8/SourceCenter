//
//  RecruitInfo.h
//  CourseCenter
//
//  Created by jian on 15/7/30.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kRecruitID                  @"RecruitID"
#define kInReadStudentNum           @"InReadStudentNum"
#define kUserLimit                  @"UserLimit"
#define kClassName                  @"ClassName"

@interface RecruitInfo : NSObject

    ///网络招生班ID
@property(nonatomic, assign) long RecruitID;
    ///班级已存在的人数
@property(nonatomic, assign) int InReadStudentNum;
    ///限制招生人数0不限
@property(nonatomic, assign) int UserLimit;
    ///网络招生班
@property(nonatomic, strong) NSString *ClassName;

- (id)initWithDict:(NSDictionary *)dict;

@end
