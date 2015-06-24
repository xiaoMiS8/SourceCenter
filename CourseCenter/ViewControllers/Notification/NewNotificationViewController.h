//
//  NewNotificationViewController.h
//  CourseCenter
//
//  Created by jian on 15/6/15.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface NewNotificationViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) void (^DoBlock)(void);

@end
