//
//  UIView1.h
//  EasyLoan
//
//  Created by muzhenhua on 15/8/6.
//  Copyright (c) 2015年 hyron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRadioButton.h"
@interface UIView1 : UIViewController<QRadioButtonDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@end
