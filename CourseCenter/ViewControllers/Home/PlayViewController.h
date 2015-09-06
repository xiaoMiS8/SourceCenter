//
//  PlayViewController.h
//  CourseCenter
//
//  Created by 2345_muzhenhua on 15/6/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"
#import "TutorialViewController.h"

@interface PlayViewController : UIViewController
@property(nonatomic,strong)NSString *playUrl;
@property(nonatomic,assign)BOOL isNSBundle;
@property(nonatomic,assign)long ChapterID;
@property(nonatomic,assign)long FileID;
@property(nonatomic,assign)long OCID;
@property(nonatomic,assign)int  Seconds;
@property(nonatomic,assign)BOOL isRecord;
@property(nonatomic,strong)TutorialViewController *tutorVC;

@property(nonatomic, copy) void (^pauseBlock)(NSInteger sends);
@end
