//
//  BaseViewController.h
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
- (void)setupCustomBackWithImage:(NSString *)imagename title:(NSString *)title;
- (void)setupCustomRightWithtitle:(NSString *)title target:(id)tar action:(SEL)act;
- (void)setupCustomRightWithImage:(UIImage *)image target:(id)tar action:(SEL)act;
@end
