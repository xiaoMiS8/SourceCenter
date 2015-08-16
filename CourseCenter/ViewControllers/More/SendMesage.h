//
//  SendMesage.h
//  CourseCenter
//
//  Created by 2345 on 15/7/18.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"
#import "TLTagsControl.h"
@interface SendMesage : BaseViewController
@property (weak, nonatomic) IBOutlet TLTagsControl *editingTagControl;
@property (strong,nonatomic)NSMutableArray *array;
@end
