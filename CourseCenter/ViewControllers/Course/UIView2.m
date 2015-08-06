//
//  UIView1.m
//  EasyLoan
//
//  Created by muzhenhua on 15/8/6.
//  Copyright (c) 2015年 hyron. All rights reserved.
//

#import "UIView2.h"

@interface UIView2 ()

@end

@implementation UIView2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBtns];
}
-(void)setBtns
{
    
    QCheckBox *_radio1 = [[QCheckBox alloc] initWithDelegate:self];
    _radio1.frame = CGRectMake(10, _label2.frame.origin.y+50,320,30);
    [_radio1 setTitle:@"ASDDD" forState:UIControlStateNormal];
    [_radio1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [self.view addSubview:_radio1];
    [_radio1 setChecked:YES];
    
    QCheckBox *_radio2 = [[QCheckBox alloc] initWithDelegate:self];
    _radio2.frame = CGRectMake(10, _radio1.frame.origin.y+30,320,30);
    [_radio2 setTitle:@"PPOLKO" forState:UIControlStateNormal];
    [_radio2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_radio2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_radio2];
    
    QCheckBox *_radio3 = [[QCheckBox alloc] initWithDelegate:self];
    _radio3.frame = CGRectMake(10, _radio2.frame.origin.y+30,320,30);
    [_radio3 setTitle:@"QWERD" forState:UIControlStateNormal];
    [_radio3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_radio3.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_radio3];
    
    QCheckBox *_radio4 = [[QCheckBox alloc] initWithDelegate:self];
    _radio4.frame = CGRectMake(10, _radio3.frame.origin.y+30,320,30);
    [_radio4 setTitle:@"OPLKJHY" forState:UIControlStateNormal];
    [_radio4 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_radio4.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_radio4];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
