//
//  NoticeActions.h
//  
//
//  Created by jian on 15/6/24.
//
//

#import <Foundation/Foundation.h>
#import "CSNetAccessor.h"

#define kOCID           @"OCID"
#define kSysID          @"SysID"
#define kModuleID       @"ModuleID"
#define kPageIndex      @"PageIndex"
#define kPageSize       @"PageSize"
#define kNoticeID       @"NoticeID"
#define kTitle          @"Title"
#define kConten         @"Conten"
#define kIsTop          @"IsTop"
#define kIsForMail      @"IsForMail"
#define kIsForSMS       @"IsForSMS"
#define kSourceIDs      @"SourceIDs"


@interface NoticeActions : NSObject

/**
 *  通知列表
 *
 *  @param OCID      在线课程ID
 *  @param SysID     系统ID 默认1
 *  @param ModuleID  0系统通知, 1课程通知 -1:全部
 *  @param PageIndex  第几页
 *  @param PageSize  每页多少个
 *  @param finished  finished description
 */
+ (void)getNoticeInfoListWithOCID:(long)OCID
                            SysID:(long)SysID
                         ModuleID:(long)ModuleID
                        PageIndex:(int)PageIndex
                         PageSize:(int)PageSize
                         finished:(FinishedBlock)finished;
/**
 *  回复列表
 *
 *  @param NoticeID  通知ID
 *  @param PageIndex 第几页
 *  @param PageSize  每页多少个
 *  @param finished  finished description
 */
+ (void)getNoticeResponseListWithNoticeID:(long)NoticeID
                                PageIndex:(int)PageIndex
                                 PageSize:(int)PageSize
                                 finished:(FinishedBlock)finished;
/**
 *  发布通知
 *
 *  @param Title     标题
 *  @param Conten    内容
 *  @param IsTop     是否置顶
 *  @param IsForMail 是否发送邮件
 *  @param IsForSMS  是否发送短信
 *  @param SourceIDs 网络教学班编号集合（逗号分隔）)
 *  @param finished  finished description
 */
+ (void)AddAppNoticeWithTitle:(NSString *)Title
                       Conten:(NSString *)Conten
                        IsTop:(BOOL)IsTop
                    IsForMail:(BOOL)IsForMail
                     IsForSMS:(BOOL)IsForSMS
                    SourceIDs:(NSArray *)SourceIDs
                     finished:(FinishedBlock)finished;

@end

