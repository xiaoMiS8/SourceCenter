//
//  GroupInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/16.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kID             @"ID"
#define kName           @"Name"
#define kType           @"Type"

@interface GroupInfo : NSObject

    //ID
@property(nonatomic, assign) long ID;
    //名称
@property(nonatomic, strong) NSString *Name;
    //类型（1教学班2组）
@property(nonatomic, assign) int Type;

- (id)initWithDict:(NSDictionary *)dict;

@end
