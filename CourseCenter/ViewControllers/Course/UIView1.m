//
//  UIView1.m
//  EasyLoan
//
//  Created by muzhenhua on 15/8/6.
//  Copyright (c) 2015年 hyron. All rights reserved.
//

#import "UIView1.h"

@interface UIView1 ()

@end

@implementation UIView1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBtns];
}
-(void)setBtns
{
    
    QRadioButton *_radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:@"123"];
    _radio1.frame = CGRectMake(10, _label2.frame.origin.y+50,320,30);
    [_radio1 setTitle:@"ASDDD" forState:UIControlStateNormal];
    [_radio1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [self.view addSubview:_radio1];
    [_radio1 setChecked:YES];
    
    QRadioButton *_radio2 = [[QRadioButton alloc] initWithDelegate:self groupId:@"123"];
    _radio2.frame = CGRectMake(10, _radio1.frame.origin.y+30,320,30);
    [_radio2 setTitle:@"PPOLKO" forState:UIControlStateNormal];
    [_radio2 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_radio2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_radio2];
    
    QRadioButton *_radio3 = [[QRadioButton alloc] initWithDelegate:self groupId:@"123"];
    _radio3.frame = CGRectMake(10, _radio2.frame.origin.y+30,320,30);
    [_radio3 setTitle:@"QWERD" forState:UIControlStateNormal];
    [_radio3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_radio3.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_radio3];
    
    QRadioButton *_radio4 = [[QRadioButton alloc] initWithDelegate:self groupId:@"123"];
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
