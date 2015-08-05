//
//  AffairsAction.h
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetAccessor.h"
#import "AffairInfo.h"


#define kAffairID           @"AffairID"

@interface AffairsAction : NSObject

/**
 *  事务申请列表
 *
 *  @param Type      1 我审核的事务, 2 我申请的事务
 *  @param OCID      在线课程ID
 *  @param IsHistory 1 历史事务  0 待处理事务  -1 全部
 *  @param PageIndex PageIndex description
 *  @param PageSize  PageSize description
 *  @param finished  finished description
 */
+ (void)getAffairsListWithType:(int)Type
                         OCID:(long)OCID
                     IsHistory:(int)IsHistory
                     PageIndex:(int)PageIndex
                      PageSize:(int)PageSize
                      finished:(FinishedBlock)finished;
/**
 *  事务审核
 *
 *  @param AffairID AffairID description
 *  @param Status   状态 0:未审核,1:拒绝, 2:同意
 *  @param finished finished description
 */
+ (void)updateOCAffairsStatusWithAffairID:(long)AffairID Status:(int)Status finished:(FinishedBlock)finished;

@end
