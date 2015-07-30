//
//  ResourseInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSourceID           @"SourceID"
#define kTitle              @"Title"
#define kIsFinish           @"IsFinish"

@interface SourceInfo : NSObject

    //作业ID/论题ID/问卷ID
@property(nonatomic, assign) long SourceID;
    //名称/问卷标题
@property(nonatomic, strong) NSString *Title;
    //是否完成
@property(nonatomic, assign) BOOL IsFinish;

- (id)initWithdict:(NSDictionary *)dict;

@end
