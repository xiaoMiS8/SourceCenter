//
//  FCOfflineInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFCOfflineID            @"FCOfflineID"
#define kFCID                   @"FCID"
#define kTitle                  @"Title"
#define kStartTime              @"StartTime"
#define kEndTime                @"EndTime"
#define kAddress                @"Address"

@interface FCOfflineInfo : NSObject

    //ID
@property(nonatomic, assign) long FCOfflineID;
    //翻转课堂ID
@property(nonatomic, assign) long FCID;
    //标题
@property(nonatomic, strong) NSString *Title;
    //开始时间
@property(nonatomic, strong) NSString *StartTime;
    //结束时间
@property(nonatomic, strong) NSString *EndTime;
    //地址
@property(nonatomic, strong) NSString *Address;

- (id)initWithDict:(NSDictionary *)dict;

@end

