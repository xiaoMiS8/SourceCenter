//
//  CourseBaseViewController.h
//  CourseCenter
//
//  Created by jian on 15/7/25.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"

@interface CourseBaseViewController : BaseViewController

@property(nonatomic, copy) void (^PushBlock)(UIViewController *viewController);

- (void) pushViewController:(UIViewController *)viewController;

@end
