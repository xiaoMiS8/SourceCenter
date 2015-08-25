//
//  SchoolInfo.h
//  CourseCenter
//
//  Created by 2345 on 15/8/25.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSchoolname                 @"schoolname"
#define kUUrl                        @"url"
#define kJwd                        @"jwd"

@interface SchoolInfo : NSObject

///学校名称
@property(nonatomic, strong) NSString * Schoolname;
///域名或IP地址
@property(nonatomic, strong) NSString * Url;
///经纬度
@property(nonatomic, strong) NSString * Jwd;

- (id)initWithDict:(NSDictionary *)dict;

@end
