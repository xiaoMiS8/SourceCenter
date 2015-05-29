//
//  NotificationInfo.h
//  CourseCenter
//
//  Created by renxiaojian on 15/5/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kname       @"name"
#define kdate       @"date"
#define ktitle      @"title"
#define kmessage    @"message"
#define kimgs       @"imgs"
#define kitems      @"items"

@interface NotificationInfo : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *date;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *message;
@property(nonatomic, strong) NSArray *imgs;
@property(nonatomic, strong) NSArray *items;

- (id)initDict:(NSDictionary *)dict;


@end

@interface Item : NSObject

@property(nonatomic, strong) NSString *itemContent;
@property(nonatomic, strong) NSString *itemName;
@property(nonatomic, strong) NSString *toName;

@end

@interface imgInfo : NSObject

@property(nonatomic, strong) NSString *url;

@end
