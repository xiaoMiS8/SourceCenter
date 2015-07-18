//
//  NewMessage.m
//  CourseCenter
//
//  Created by 2345 on 15/7/16.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NewMessage.h"
#import "NewMessageCell.h"
#import "SendMesage.h"
#define SECTION_STATE @"SECTION_STATE"
@interface NewMessage ()
{
    NSMutableArray *_array;
    NSMutableArray *_arrayData;
    NSMutableArray *_subArray;
    NSMutableDictionary *_dict;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation NewMessage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"新建消息";
    [self setupCustomRightWithtitle:@"确定" target:self action:@selector(sure)];
    _array=[NSMutableArray arrayWithCapacity:0];
    _arrayData=[NSMutableArray arrayWithCapacity:0];
    _subArray=[NSMutableArray arrayWithCapacity:0];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewMessageCell" bundle:nil] forCellReuseIdentifier:@"NewMessageCell"];
_arrayData=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
_subArray=@[@[@"1",@"3",@"4",@"sss",],@[@"2"],@[@"3"],@[@"4"],@[@"5"],@[@"6"],@[@"7"],@[@"8"],@[@"9"],@[@"10"]];
    [self showCourseData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[[NSBundle mainBundle]loadNibNamed:@"HeadForTable" owner:self options:nil]objectAtIndex:0];
    _head_title.text=[NSString stringWithFormat:@"金融管理070%d班",section];
    _headbtn.tag=section+100;
    [_headbtn addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
    return view;
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
}
-(void)showCourseData
{
    for (int i=0; i<_arrayData.count; i++) {
        _dict=[NSMutableDictionary dictionaryWithCapacity:0];
        [_dict setObject:[NSNumber numberWithBool:YES] forKey:SECTION_STATE];
        [_array addObject:_dict];
    }
    [_tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrayData.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *di=[_array objectAtIndex:section];
    NSNumber *number=[di objectForKey:SECTION_STATE];
    if ([number boolValue]) {
        return 0;
    }else
    {
        return ((NSMutableArray *)[_subArray objectAtIndex:section]).count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewMessageCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"NewMessageCell"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)sure
{
    SendMesage *sendMessage=[[SendMesage alloc]
                             init];
    [((AppDelegate *)app).nav pushViewController:sendMessage animated:YES];
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
