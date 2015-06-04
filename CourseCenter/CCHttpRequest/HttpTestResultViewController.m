//
//  HttpTestResultViewController.m
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "HttpTestResultViewController.h"

@interface HttpTestResultViewController ()

@end

@implementation HttpTestResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)setResult:(NSString *)result {
    _result = result;
    self.resultText.text = result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
