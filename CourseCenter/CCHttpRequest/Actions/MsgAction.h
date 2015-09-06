//
//  MsgAction.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/14.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kkey            @"key"
#define kPageIndex      @"PageIndex"
#define kPageSize       @"PageSize"
#define kUserID         @"UserID"
#define kTitle          @"Title"
#define kConten         @"Conten"
#define kReceiveUserIDs @"ReceiveUserIDs"
#define kID             @"ID"
#define kType           @"Type"

@interface MsgAction : NSObject

/**
 *  @brief  获取未读消息数
 *
 *  @param finished finished description
 */
+ (void)getAppUnReadMessageCountWithfinished:(FinishedBlock)finished;
/**
 *  @brief  发送消息消息列表
 *
 *  @param key       关键词
 *  @param PageIndex 第几页
 *  @param PageSize  每页大小
 */
+ (void)getAppMessageListWithkey:(NSString *)key
                       PageIndex:(int)PageIndex
                        PageSize:(int)PageSize
                        finished:(FinishedBlock)finished;
/**
 *  @brief  消息详细
 *
 *  @param UserID  用户Id
 *  @param finished finished
 */
+ (void)getAppMessageWithUserID:(long)UserID
                       finished:(FinishedBlock)finished;
/**
 *  @brief  发送消息
 *
 *  @param Title          Title
 *  @param Conten         Conten
 *  @param ReceiveUserIDs 收信人ID集合
 *  @param finished       finished
 */
+ (void)addAppMessageWithTitle:(NSString *)Title
                        Conten:(NSString *)Conten
                ReceiveUserIDs:(NSArray *)ReceiveUserIDs
                      finished:(FinishedBlock)finished;
/**
 *  @brief  某人所在的所有教学班及组
 *
 *  @param finished finished 
 */
+ (void)getOCClassListWithfinished:(FinishedBlock)finished;

/**
 *  @brief  教学班下联系人
 *
 *  @param ID          ID
 *  @param Type         1教学班, 2组, -1全部
 *  @param finished       finished
 */
+ (void)getAppClassUserListwithID:(long)ID
                             Type:(int)Type
                         finished:(FinishedBlock)finished;

@end
