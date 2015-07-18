//
//  SendMesage.m
//  CourseCenter
//
//  Created by 2345 on 15/7/18.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "SendMesage.h"

@interface SendMesage ()

@end

@implementation SendMesage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"新建消息";
    [self setupCustomRightWithtitle:@"发送" target:self action:@selector(sureMessage)];
    NSMutableArray *tags = [NSMutableArray arrayWithArray:@[@"张一鸣", @"王晓明", @"赵非凡", @"张一鸣", @"王晓明", @"赵非凡", @"张一鸣", @"王晓明", @"赵非凡"]];
    _editingTagControl.tags = [tags mutableCopy];
    _editingTagControl.tagPlaceholder=@"";
    [_editingTagControl reloadTagSubviews];
}
-(void)sureMessage
{
    
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
