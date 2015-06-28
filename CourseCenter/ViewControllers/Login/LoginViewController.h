//
//  LoginViewController.h
//  CourseCenter
//
//  Created by Mac on 15-5-27.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^returnHomeBlock)(void);
@interface LoginViewController : BaseViewController
@property(nonatomic,strong)returnHomeBlock block;
@end
