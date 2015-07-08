//
//  TeachingClassInfo.m
//  CourseCenter
//
//  Created by jian on 15/7/4.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "TeachingClassInfo.h"

@implementation TeachingClassInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.TeachingClassID = [[dict objectForKey:kTeachingClassID] longValue];
        self.TeachingClassName = [dict objectForKey:kTeachingClassName];
        self.RowsCount = [[dict objectForKey:kRowsCount] intValue];
    }
    return self;
}

@end
