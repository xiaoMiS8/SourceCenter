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

@interface MsgInfo : NSObject

    //未读数
@property(nonatomic, assign) int UnReadCount;
    //用户头像
@property(nonatomic, strong) NSString *UserImgUrl;
    //内容
@property(nonatomic, strong) NSString *Conten;
    //用户ID
@property(nonatomic, assign) long UserID;
    //姓名
@property(nonatomic, strong) NSString *UserName;
    //发送时间
@property(nonatomic, strong) NSString *CreateTime;

- (id)initWithdict:(NSDictionary *)dict;

@end
