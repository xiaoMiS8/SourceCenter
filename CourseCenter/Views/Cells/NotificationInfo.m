//
//  NotificationInfo.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NotificationInfo.h"

@implementation NotificationInfo

- (id)init {
    self = [super init];
    if (self) {
        self.name = @"系统管理员";
        self.date = @"2015-5-28 12:00";
        self.title = @"2015春夏学期新生看过来~";
        self.message = @"同学您好，在注册报到后请同学们及时开始课程的在线教程学习。如果到清退截止时间您还没有开始学习，即您的学习进度显示仍旧为零的话，将一律会被平台清退，不能再登录平台继续这门课程的学习。上海地区选课学校：根据上海共享中心与各选课学校的约定，清退的时间按照各选课学校的规定执行，选课学校清退后请及时通知智慧树平台。如果选课学校没有规定的，课程中心平台执行清退的最后截止时间为3月30日24:00点。其它区域的选课学校：如果选课学校有规定的请以正式函的形式通知课程中心平台，若没有特别说明的，课程中心平台统一的最后清退截止时间为4月15日24:00点。";
        self.imgs = @[@"mm1",@"mm2",@"mm3",@"mm4",@"mm5",@"mm6"];
        self.items = @[@"mmm",@"hhh",@"777"];
    }
    return self;
}

@end
