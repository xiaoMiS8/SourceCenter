//
//  ApplyViewController.m
//  CourseCenter
//
//  Created by 2345 on 15/8/1.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "ApplyViewController.h"
@interface ApplyViewController ()
@property(nonatomic,assign) NSInteger myrow;
@end

@implementation ApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupCustomRightWithtitle:@"确定" target:self action:@selector(sure)];
    _myrow=100000;
    NSArray *array = @[@"教学班注册",@"网络班注册"];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:array];
    seg.selectedSegmentIndex = 0;
    seg.bounds = CGRectMake(0, 0, 160, 30);
    self.navigationItem.titleView =seg;
    [seg addTarget:self action:@selector(segValueChange:) forControlEvents:UIControlEventValueChanged];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Swidth, 40)];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(-1, -1, Swidth+2, 40)];
    lable.layer.borderColor=[UIColor grayColor].CGColor;
    lable.layer.borderWidth=1;
    lable.font=[UIFont systemFontOfSize:14];
    lable.numberOfLines=0;
    lable.textAlignment=NSTextAlignmentCenter;
    lable.text=@"请选择网络招生班级,点击下方注册按钮报名:";
    [view addSubview:lable];
    
    _tableView.tableHeaderView=view;
}
- (void)segValueChange:(UISegmentedControl *)seg {
    if (seg.selectedSegmentIndex == 0) {
        _tableView.hidden=YES;
        _titleL.hidden=NO;
        _textF.hidden=NO;
    }
    else {
        _tableView.hidden=NO;
        _titleL.hidden=YES;
        _textF.hidden=YES;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
  if (!cell) {
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,80, cell.frame.size.height)];
    lable.textAlignment=NSTextAlignmentRight;
    lable.text=@"20/100";
    cell.accessoryView=lable;
   }
    if (_myrow!=100000) {
        if (_myrow==indexPath.row) {
           cell.imageView.image=[UIImage imageNamed:@"btn_confirm_hover"];
        }else
        {
         cell.imageView.image=[UIImage imageNamed:@"btn_confirm"];
        }
    }else
    {
    cell.imageView.image=[UIImage imageNamed:@"btn_confirm"];
    }
    cell.textLabel.text =[NSString stringWithFormat:@"网络招生0702班"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_myrow!=indexPath.row) {
        _myrow=indexPath.row;
        [_tableView reloadData];
    }
}
-(void)sure
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
