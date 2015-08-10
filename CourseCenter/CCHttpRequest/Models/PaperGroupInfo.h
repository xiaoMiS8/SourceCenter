//
//  PaperGroupInfo.h
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGroupID            @"GroupID"
#define kPaperID            @"PaperID"
#define kGroupName          @"GroupName"
#define kOrde               @"Orde"
#define kBrief              @"Brief"
#define kTimelimit          @"Timelimit"

@interface PaperGroupInfo : NSObject

    ///分组ID
@property(nonatomic, assign) long GroupID;
    ///试卷ID
@property(nonatomic, assign) long PaperID;
    ///分组名称
@property(nonatomic, strong) NSString *GroupName;
    ///排序
@property(nonatomic, strong) NSString *Orde;
    ///分组介绍
@property(nonatomic, strong) NSString *Brief;
    ///分组时长
@property(nonatomic, assign) int Timelimit;

- (id)initWithDict:(NSDictionary *)dict;

@end

