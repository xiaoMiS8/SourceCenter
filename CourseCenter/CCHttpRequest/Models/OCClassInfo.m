//
//  OCClassInfo.m
//  CourseCenter
//
//  Created by jian on 15/7/30.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "OCClassInfo.h"

@implementation OCClassInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.OCClassID = [dict[kOCClassID] longValue];
        self.TeachingClassID = [dict[kTeachingClassID] longValue];
        self.TeachingClassName = dict[kTeachingClassName];
    }
    return self;
}

@end
