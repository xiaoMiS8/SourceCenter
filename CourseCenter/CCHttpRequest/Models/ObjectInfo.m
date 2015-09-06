//
//  ObjectInfo.m
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "ObjectInfo.h"

@implementation ObjectInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.ObjectID = [dict[kObjectID] longValue];
        self.ObjectName = dict[kObjectName];
        self.IsFinish = [dict[kIsFinish] boolValue];
    }
    return self;
}

@end
