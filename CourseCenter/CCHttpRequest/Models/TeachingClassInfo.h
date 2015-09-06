//
//  TeachingClassInfo.h
//  CourseCenter
//
//  Created by jian on 15/7/4.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTeachingClassID            @"TeachingClassID"
#define kTeachingClassName          @"TeachingClassName"
#define kRowsCount                  @"RowsCount"

@interface TeachingClassInfo : NSObject

    //教学班ID
@property(nonatomic, assign) long TeachingClassID;
    //教学班名称
@property(nonatomic, strong) NSString *TeachingClassName;
    //列表总数
@property(nonatomic, assign) int RowsCount;

- (id)initWithDict:(NSDictionary *)dict;

@end

