//
//  CGroupInfo.h
//  CourseCenter
//
//  Created by jian on 15/7/27.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGroupID                @"GroupID"
#define kName                   @"Name"
#define kUserCount              @"UserCount"
#define kRanKInfo               @"RanKInfo"
#define kGroupCount             @"GroupCount"
#define kGroupProgress          @"GroupProgress"

@interface CGroupInfo : NSObject
    ///小组ID
@property(nonatomic, assign) long GroupID;
    ///小组名称
@property(nonatomic, strong) NSString *Name;
    ///小组人数
@property(nonatomic, assign) int UserCount;
    ///排名
@property(nonatomic, strong) NSString *RanKInfo;
    ///一共多少组
@property(nonatomic, assign) int GroupCount;
    ///小组进度
@property(nonatomic, assign) float GroupProgress;

- (id)initWithDict:(NSDictionary *)dict;

@end
