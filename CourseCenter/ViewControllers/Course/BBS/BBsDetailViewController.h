//
//  BBsDetailViewController.h
//  CourseCenter
//
//  Created by jian on 15/8/3.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "CourseBaseViewController.h"
#import "TopicInfo.h"

@interface BBsDetailViewController : CourseBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) TopicInfo *topic;

@end
