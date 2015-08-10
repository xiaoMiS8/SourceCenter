//
//  OCClassInfo.h
//  CourseCenter
//
//  Created by jian on 15/7/30.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kOCClassID              @"OCClassID"
#define kTeachingClassID        @"TeachingClassID"
#define kTeachingClassName      @"TeachingClassName"

@interface OCClassInfo : NSObject

    ///在线教学班ID
@property(nonatomic, assign) long OCClassID;
    ///教学班ID
@property(nonatomic, assign) long TeachingClassID;
    ///教学班名称
@property(nonatomic, strong) NSString *TeachingClassName;

- (id)initWithDict:(NSDictionary *)dict;

@end
