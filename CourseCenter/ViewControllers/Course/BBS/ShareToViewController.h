//
//  ShareToViewController.h
//  CourseCenter
//
//  Created by 任晓健 on 15/8/9.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"

@interface ShareToViewController : BaseViewController

@property(nonatomic, assign) long OCID;

@property(nonatomic, copy) void (^doneBlock)(NSArray *forums);

@end
