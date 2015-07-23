//
//  SetViewController.h
//  CourseCenter
//
//  Created by 2345 on 15/7/12.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"
#import "UserInfo.h"
typedef void(^ popViewBlock) ();
@interface SetViewController : BaseViewController
@property(nonatomic,strong)popViewBlock block;
@property (strong,nonatomic)UserInfo *userInfo;
@end
