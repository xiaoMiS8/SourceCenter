//
//  ObjectInfo.h
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kObjectID               @"ObjectID"
#define kObjectName             @"ObjectName"
#define kIsFinish               @"IsFinish"

@interface ObjectInfo : NSObject

    ///被评对象ID
@property(nonatomic, assign) long ObjectID;
    ///被评对象姓名
@property(nonatomic, strong) NSString *ObjectName;
    ///是否完成评价
@property(nonatomic, assign) BOOL IsFinish;

- (id)initWithDict:(NSDictionary *)dict;

@end

