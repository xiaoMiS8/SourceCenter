//
//  BBsViewController.h
//  CourseCenter
//
//  Created by jian on 15/7/25.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "CourseBaseViewController.h"

@interface BBsViewController : CourseBaseViewController

@property(nonatomic, strong) UIButton *rightBtn1;
@property(nonatomic, strong) UIButton *rightBtn2;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
