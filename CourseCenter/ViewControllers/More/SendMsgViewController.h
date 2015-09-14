//
//  SendMsgViewController.h
//  CourseCenter
//
//  Created by rxj on 15/9/14.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"
#import "MessageCenter.h"

@interface SendMsgViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bomView;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
@property (weak, nonatomic) IBOutlet UIButton *imgBtn;

@property (strong,nonatomic)NSMutableArray *array;
@property (nonatomic,strong)MessageCenter *messageCenter;

@property(nonatomic, assign) long OCID;
@property(nonatomic, copy) void (^doBlock)(void);

@end
