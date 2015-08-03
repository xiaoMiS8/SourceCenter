//
//  TPViewController.m
//  CourseCenter
//
//  Created by jian on 15/7/25.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "TPViewController.h"

@interface TPViewController ()

@end

@implementation TPViewController

- (void)setRightBtn:(UIButton *)rightBtn {
    _rightBtn = rightBtn;
    [rightBtn setImage:[UIImage imageNamed:@"btn_history"] forState:UIControlStateNormal];
    [rightBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)rightBtnAction:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
