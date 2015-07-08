//
//  NotiDetailViewController.h
//  CourseCenter
//
//  Created by renxiaojian on 15/5/29.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"
#import "NotificationInfo.h"
#import "NoticeInfo.h"
@interface NotiDetailViewController : BaseViewController

@property(nonatomic, strong) NotificationInfo *notification;
@property(nonatomic, strong) NoticeInfo *noticeInfo;

@end
