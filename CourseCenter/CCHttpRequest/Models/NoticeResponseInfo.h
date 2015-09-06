//
//  NoticeResponseInfo.h
//  CourseCenter
//
//  Created by jian on 15/6/26.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kResponseID             @"ResponseID"
#define kNoticeID               @"NoticeID"
#define kUserID                 @"UserID"
#define kUserName               @"UserName"
#define kConten                 @"Conten"
#define kUpdateTime             @"UpdateTime"
#define kClassName              @"ClassName"
#define kIsTop                  @"IsTop"
#define kCurrentTime            @"CurrentTime"
#define kResponseTimeStr        @"ResponseTimeStr"

@interface NoticeResponseInfo : NSObject

    //回复ID
@property(nonatomic, assign) long           ResponseID;
    //通知ID
@property(nonatomic, assign) long           NoticeID;
    //用户ID
@property(nonatomic, assign) long           UserID;
    //姓名
@property(nonatomic, strong) NSString       *UserName;
    //内容
@property(nonatomic, strong) NSString       *Conten;
    //更新时间
@property(nonatomic, strong) NSString       *UpdateTime;
    //班级班名
@property(nonatomic, strong) NSString       *ClassName;
    //是否置顶
@property(nonatomic, assign) BOOL           IsTop;
    //当前时间
@property(nonatomic, strong) NSString       *CurrentTime;
    //发表于1 天前
@property(nonatomic, strong) NSString       *ResponseTimeStr;
@property(nonatomic, strong) NSString       *toName;

- (id)initWithDict:(NSDictionary *)dict;

@end
