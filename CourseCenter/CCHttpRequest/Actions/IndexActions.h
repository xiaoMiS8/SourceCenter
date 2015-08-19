//
//  IndexActions.h
//  
//
//  Created by jian on 15/6/19.
//
//

#import <Foundation/Foundation.h>
#import "CSNetAccessor.h"

#define kSpecialtyTypeID            @"SpecialtyTypeID"
#define kkey                        @"key"
#define kPageIndex                  @"PageIndex"
#define kPageSize                   @"PageSize"
#define kParentID                   @"ParentID"
#define kOCID                       @"OCID"
#define kChapterID                  @"ChapterID"
#define kFileType                   @"FileType"
#define kSearchKey                  @"SearchKey"

@interface IndexActions : NSObject

/**
 *  推荐课程
 *
 *  @param finished finished description
 */
+ (void)getRecommendCourseListWithfinished:(FinishedBlock)finished;
/**
 *  全部课程
 *
 *  @param SpecialtyTypeID 学科ID
 *  @param key             关键字
 *  @param PageIndex       第几页
 *  @param PageSize        每页大小
 *  @param finished        finished description
 */
+ (void)getOCAllListWithSpecialtyTypeID:(long)SpecialtyTypeID
                                    key:(NSString *)key
                              PageIndex:(int)PageIndex
                               PageSize:(int)PageSize
                               finished:(FinishedBlock)finished;
/**
 *  学科列表
 *
 *  @param ParentID 父级ID
 *  @param finished finished description
 */
+ (void)getSpecialtyTypeTreeWithParentID:(long)ParentID
                               SearchKey:(NSString *)searchKey
                                finished:(FinishedBlock)finished;
/**
 *  Mooc基本信息
 *
 *  @param OCID     父级ID
 *  @param finished finished description
 */
+ (void)getAppOCMoocGetWithOCID:(long)OCID
                         finished:(FinishedBlock)finished;
/**
 *  课程章节
 *
 *  @param OCID     父级ID
 *  @param finished finished description
 */
+ (void)getChapterStudyListwithOCID:(long)OCID
                           finished:(FinishedBlock)finished;
/**
 *  章节下资料列表
 *
 *  @param OCID      父级ID
 *  @param ChapterID 章节ID
 *  @param FileType  资料类型
 *  @param finished  finished description
 */
+ (void)getOCMoocFileStudyListwithOCID:(long)OCID
                              ChapterID:(long)ChapterID
                               FileType:(int)FileType
                               finished:(FinishedBlock)finished;

/**
 *	@brief	非视频资源下载完成调用
 *
 *	@param 	ChapterID 	章节ID
 *	@param 	FileID 	    资源文件编号
 *	@param 	IsFinish 	资源是否学习完成
 *	@param 	finished 	finished description
 */
+ (void)addOCMoocStuFilewithChapterID:(long)ChapterID
                                   FileID:(int)FileID
                                   IsFinish:(int)IsFinish
                                  finished:(FinishedBlock)finished;

@end
