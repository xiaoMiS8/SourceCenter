//
//  LiveForumInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFCID           @"FCID"
#define kFCLiveID       @"FCLiveID"
#define kTopicID        @"TopicID"
#define kTitle          @"Title"
#define kBrief          @"Brief"
#define kResponses      @"Responses"
#define kLastUserName   @"LastUserName"

@interface LiveForumInfo : NSObject

    ///翻转课堂ID
@property(nonatomic, assign) long FCID;
    ///ID,
@property(nonatomic, assign) long FCLiveID;
    ///论题ID,
@property(nonatomic, assign) long TopicID;
    ///标题
@property(nonatomic, strong) NSString *Title;
    ///内容
@property(nonatomic, strong) NSString *Brief;
    ///回复数
@property(nonatomic, assign) int Responses;
    ///最后回复人
@property(nonatomic, strong) NSString *LastUserName;

- (id)initWithDict:(NSDictionary *)dict;

@end
