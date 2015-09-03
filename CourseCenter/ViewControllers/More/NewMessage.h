//
//  NewMessage.h
//  CourseCenter
//
//  Created by 2345 on 15/7/16.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"
#import "MessageCenter.h"
@interface NewMessage : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *head_title;
@property (weak, nonatomic) IBOutlet UIButton *head_btn_right;
@property (weak, nonatomic) IBOutlet UIButton *head_btn_left;
@property (nonatomic,strong)MessageCenter *messageCenter;
@end
