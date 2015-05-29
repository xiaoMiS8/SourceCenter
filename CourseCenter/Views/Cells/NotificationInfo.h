//
//  NotificationInfo.h
//  CourseCenter
//
//  Created by renxiaojian on 15/5/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationInfo : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *date;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *message;
@property(nonatomic, strong) NSArray *imgs;
@property(nonatomic, strong) NSArray *items;


@end
