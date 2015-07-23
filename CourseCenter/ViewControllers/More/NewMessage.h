//
//  NewMessage.h
//  CourseCenter
//
//  Created by 2345 on 15/7/16.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"

@interface NewMessage : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *head_img;
@property (weak, nonatomic) IBOutlet UILabel *head_title;
@property (weak, nonatomic) IBOutlet UIButton *headbtn;
@property (weak, nonatomic) IBOutlet UIButton *head_btn_left;
@property (strong,nonatomic)NSString *selectAll;
@end
