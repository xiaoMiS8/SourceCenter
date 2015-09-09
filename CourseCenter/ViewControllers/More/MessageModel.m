//
//  MessageModel.m
//  CourseCenter
//
//  Created by 2345 on 15/7/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

+ (id)messageModelWithDict:(NSDictionary *)dict
{
    MessageModel *message = [[self alloc] init];
    message.text = dict[@"text"];
    message.time = dict[@"time"];
    message.type = [dict[@"type"] intValue];
    message.imgurl = dict[@"imgurl"];
    return message;
}

@end
