//
//  UIView1.h
//  EasyLoan
//
//  Created by muzhenhua on 15/8/6.
//  Copyright (c) 2015年 hyron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"
@interface UIView2 : UIViewController<QCheckBoxDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@end
