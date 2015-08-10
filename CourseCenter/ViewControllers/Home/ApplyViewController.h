//
//  ApplyViewController.h
//  CourseCenter
//
//  Created by 2345 on 15/8/1.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^returnHomeBlock)(void);
@interface ApplyViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UITextField *textF;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, assign) long       OCID;
@property(nonatomic,strong)returnHomeBlock block;
@end
