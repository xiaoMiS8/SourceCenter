//
//  MsgInfo.h
//  CourseCenter
//
//  Created by jian on 15/7/15.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kUnReadCount        @"UnReadCount"
#define kUserImgUrl         @"UserImgUrl"
#define kConten             @"Conten"
#define kUserID             @"UserID"
#define kUserName           @"UserName"
#define kCreateTime         @"CreateTime"
#define kSendOrReceive      @"SendOrReceive"

@interface MsgInfo : NSObject

    //未读数
@property(nonatomic, assign) int UnReadCount;
    //用户头像
@property(nonatomic, strong) NSString *UserImgUrl;
@property(nonatomic, assign) int Gender;
    //内容
@property(nonatomic, strong) NSString *Conten;
    //用户ID
@property(nonatomic, assign) long UserID;
    //姓名
@property(nonatomic, strong) NSString *UserName;
    //发送时间
@property(nonatomic, strong) NSString *CreateTime;
    //发信人或收信人
@property(nonatomic, strong) NSString *SendOrReceive;

- (id)initWithDict:(NSDictionary *)dict;

@end
