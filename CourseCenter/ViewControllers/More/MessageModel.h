//
//  MessageModel.h
//  CourseCenter
//
//  Created by 2345 on 15/7/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef enum {
    kdefault,
    kMessageModelTypeOther,
    kMessageModelTypeMe
} MessageModelType;

@interface MessageModel : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) MessageModelType type;
@property (nonatomic, assign) BOOL showTime;
@property (nonatomic, strong) NSMutableArray *imgurl;

+ (id)messageModelWithDict:(NSDictionary *)dict;

@end
