//
//  CourseActions.h
//  CourseCenter
//
//  Created by jian on 15/7/4.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetAccessor.h"
#import "RecruitInfo.h"

#define kIsHistroy              @"IsHistroy"
#define kRegNum                 @"RegNum"

@interface CourseActions : NSObject

/**
 *  我的课程列表
 *
 *  @param IsHistroy      是否历史课程默认-1全部
 *  @param finished  finished description
 */
+ (void)getAppOCListWithIsHistroy:(int)IsHistroy
                         finished:(FinishedBlock) finished;
/**
 *  可以报名的网络招生班级列表
 *
 *  @param OCID      OCID
 *  @param finished  finished description
 */
+ (void)getOCMoocRecruitCanListWithOCID:(long)OCID
                               finished:(FinishedBlock)finished;
/**
 *  报名网络招生班级
 *
 *  @param RecruitID      RecruitID
 *  @param finished  finished description
 */
+ (void)jsonOCMoocRecruitClassWithRecruitID:(long)RecruitID
                                   finished:(FinishedBlock)finished;
/**
 *  注册在线教学班
 *
 *  @param RegNum    注册码
 *  @param OCID      OCID
 *  @param finished  finished description
 */
+ (void)OCRegisterWithRegNum:(NSString *)RegNum
                        OCID:(long)OCID
                    finished:(FinishedBlock)finished;

@end
