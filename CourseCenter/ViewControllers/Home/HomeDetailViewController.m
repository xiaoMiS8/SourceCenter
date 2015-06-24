//
//  HomeDetailViewController.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/26.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "CourseDetailCell.h"
#define SECTION_STATE @"SECTION_STATE"
@interface HomeDetailViewController ()
{
    NSMutableArray *_array;
    NSMutableDictionary *_dict;
}
@property (weak, nonatomic) IBOutlet UIView *oneV;
@property (weak, nonatomic) IBOutlet UIView *twoV;
@property (weak, nonatomic) IBOutlet UIView *threeV;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"课程";
    self.oneV.layer.borderColor=RGBA(205, 205, 205, 1).CGColor;
    self.oneV.layer.borderWidth=1;
    self.twoV.layer.borderColor=RGBA(205, 205, 205, 1).CGColor;
    self.twoV.layer.borderWidth=1;
    self.threeV.layer.borderColor=RGBA(205, 205, 205, 1).CGColor;
    self.threeV.layer.borderWidth=1;
    [self addTableViewheader];
    [self.tableView registerNib:[UINib nibWithNibName:@"CourseDetailCell" bundle:nil] forCellReuseIdentifier:@"CourseDetailCell"];
    _array=[NSMutableArray arrayWithCapacity:0];
    for (int section='A'; section<='Z'; section++) {
        _dict=[NSMutableDictionary dictionaryWithCapacity:0];
        
        [_dict setObject:[NSNumber numberWithBool:YES] forKey:SECTION_STATE];
        [_array addObject:_dict];
    }
    
}
- (void)addTableViewheader
{
    UIView *view = [UIView new];
    view.bounds = CGRectMake(0, 0, 0, 30);
    view.layer.borderColor=RGBA(205, 205, 205, 1).CGColor;
    view.layer.borderWidth=1;
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(35, 2.5, 25, 25)];
    image.image=[UIImage imageNamed:@"icon_catalog"];
    [view addSubview:image];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.origin.x+image.frame.size.width+30, 0, 100, 30)];
    lable.text=@"课程章节";
    lable.font=Font_14;
    [view addSubview:lable];
    self.tableView.tableHeaderView = view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _array.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *di=[_array objectAtIndex:section];
    NSNumber *number=[di objectForKey:SECTION_STATE];
    if ([number boolValue]) {
        return 0;
    }else
    {
        return 5;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0,_tableView.frame.size.width , 50);
    view.backgroundColor=[UIColor whiteColor];
    view.layer.borderColor=RGBA(205, 205, 205, 1).CGColor;
    view.layer.borderWidth=0.5;
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, _tableView.frame.size.width-20, 50)];
    lable.font=Font_14;
    lable.text=@"第一章 大熊猫的生活习性";
    [view addSubview:lable];
    UIButton *button=[[UIButton alloc]init];
    button.frame=CGRectMake(0, 0,_tableView.frame.size.width , 50);
    button.backgroundColor=[UIColor clearColor];
    button.tag=section+100;
    [button addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CourseDetailCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CourseDetailCell"];
    return cell;
}
-(void)press:(UIButton *)but
{
    NSMutableDictionary *dicto=[_array objectAtIndex:but.tag-100];
    NSNumber *num=[dicto objectForKey:SECTION_STATE];
    if ([num boolValue]) {
        [dicto setObject:[NSNumber numberWithBool:NO] forKey:SECTION_STATE];
    }else
    {
        [dicto setObject:[NSNumber numberWithBool:YES] forKey:SECTION_STATE];
    }
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:but.tag-100] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"%d",but.tag-100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
