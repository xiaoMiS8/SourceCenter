//
//  NoticeInfo.h
//  CourseCenter
//
//  Created by jian on 15/6/26.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoticeResponseInfo.h"

#define kNoticeID               @"NoticeID"
#define kUserID                 @"UserID"
#define kUserName               @"UserName"
#define kTitle                  @"Title"
#define kConten                 @"Conten"
#define kUpdateTime             @"UpdateTime"
#define kModuleID               @"ModuleID"
#define kIsTop                  @"IsTop"
#define kEndDate                @"EndDate"
#define kLastUser               @"LastUser"
#define kLastResponseTime       @"LastResponseTime"
#define kResponseCount          @"ResponseCount"
#define kIsCanDel               @"IsCanDel"
#define krowscount              @"rowscount"
#define kNoticeResponse         @"NoticeResponse"

@interface NoticeInfo : NSObject

    //通知ID
@property(nonatomic, assign) long           NoticeID;
    //用户ID
@property(nonatomic, assign) long           UserID;
    //姓名
@property(nonatomic, strong) NSString       *UserName;
    //通知标题
@property(nonatomic, strong) NSString       *Title;
    //通知内容
@property(nonatomic, strong) NSString       *Conten;
    //更新时间
@property(nonatomic, strong) NSString       *UpdateTime;
    //模块ID
@property(nonatomic, assign) long           ModuleID;
    //是否置顶
@property(nonatomic, assign) long           IsTop;
    //截止时间
@property(nonatomic, strong) NSString       *EndDate;
    //最后回复人
@property(nonatomic, strong) NSString       *LastUser;
    //回复时间
@property(nonatomic, strong) NSString       *LastResponseTime;
    //回复数
@property(nonatomic, assign) int            ResponseCount;
    //是否可以删除
@property(nonatomic, assign) BOOL           IsCanDel;
    //列表总数
@property(nonatomic, assign) int            rowscount;
    //回复
@property(nonatomic, strong) NSArray        *NoticeResponse;

- (id)initWithDict:(NSDictionary *)dict;


@end

