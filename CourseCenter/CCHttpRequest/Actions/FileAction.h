//
//  FileAction.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/16.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetAccessor.h"

#define kOCID           @"OCID"
#define krole           @"role"
#define kIsHistroy      @"IsHistroy"
#define kSearchkey      @"Searchkey"
#define kFileType       @"FileType"
#define kPageIndex      @"PageIndex"
#define kPageSize       @"PageSize"

@interface FileAction : NSObject

/**
 *  @brief  获取资源分类数量
 *
 *  @param OCID     OCID
 *  @param finished finished
 */
+ (void)getAppFileCountWithOCID:(long)OCID
                       finished:(FinishedBlock)finished;
/**
 *  @brief  获取某人的课程名称列表
 *
 *  @param role      1:教师, 2:学生
 *  @param IsHistroy IsHistroy
 *  @param finished  finished
 */
+ (void)getAppOCNameListWithrole:(int)role
                       IsHistroy:(BOOL)IsHistroy
                        finished:(FinishedBlock)finished;
/**
 *  @brief  获取资料的列表信息
 *
 *  @param Searchkey 搜索关键词
 *  @param OCID      OCID
 *  @param FileType  文件类型
 *  @param PageIndex 第几页
 *  @param PageSize  每页大小
 *  @param finished  finished
 */
+ (void)getAppFileSearchwithSearchkey:(NSString *)Searchkey
                                 OCID:(long)OCID
                             FileType:(int)FileType
                            PageIndex:(int)PageIndex
                             PageSize:(int)PageSize
                             finished:(FinishedBlock)finished;

@end
