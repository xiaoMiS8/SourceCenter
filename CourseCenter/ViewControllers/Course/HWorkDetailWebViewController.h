//
//  HWorkDetailWebViewController.h
//  CourseCenter
//
//  Created by muzhenhua on 15/8/26.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"

@interface HWorkDetailWebViewController : BaseViewController<UIWebViewDelegate,UIAlertViewDelegate>
@property(nonatomic,assign)long TestID;

@property(nonatomic, copy) void (^popBlock)(void);
@end
