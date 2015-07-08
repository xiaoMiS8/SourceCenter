//
//  CourseActions.h
//  CourseCenter
//
//  Created by jian on 15/7/4.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetAccessor.h"

#define kIsHistroy              @"IsHistroy"

@interface CourseActions : NSObject

/**
 *  我的课程列表
 *
 *  @param IsHistroy      是否历史课程默认-1全部
 *  @param finished  finished description
 */
+ (void)getAppOCListWithIsHistroy:(int)IsHistroy
                         finished:(FinishedBlock) finished;

@end
