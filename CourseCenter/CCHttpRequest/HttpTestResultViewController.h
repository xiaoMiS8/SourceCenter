//
//  HttpTestResultViewController.h
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface HttpTestResultViewController :BaseViewController
@property (weak, nonatomic) IBOutlet UITextView *resultText;

@property(nonatomic,strong) NSString *result;

@end
