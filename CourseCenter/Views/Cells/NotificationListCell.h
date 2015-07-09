//
//  NotificationListCell.h
//  CourseCenter
//
//  Created by renxiaojian on 15/5/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationInfo.h"
#import "NoticeInfo.h"
@interface NotificationListCell : UITableViewCell

@property(nonatomic, strong) NoticeInfo *noticeInfo;
@property(nonatomic, strong) NSArray *noticeRespones;
@property(nonatomic, strong) NotificationInfo *notification;
@property(nonatomic, assign) BOOL isDetail;

@property(nonatomic, assign) CGFloat cellHeight;


@end
