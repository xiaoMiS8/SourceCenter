//
//  FCourseDetailViewController.m
//  CourseCenter
//
//  Created by muzhenhua on 15/8/3.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "FCourseDetailViewController.h"
#import "OCFCLearnNavInfo.h"
#define SECTION_STATE @"SECTION_STATE"
@interface FCourseDetailViewController ()
{
    NSMutableArray *_array;
    NSMutableDictionary *_dict;
    OCFCLearnNavInfo *_info;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property(nonatomic, strong) NSMutableArray *list;
@end

@implementation FCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupCustomRightWithImage:[UIImage imageNamed:@"btn_class"] target:self action:@selector(pushMemberViewController)];
    self.httpManager = [[CCHttpManager alloc]init];
    self.list=[[NSMutableArray alloc]init];
    _dict=[[NSMutableDictionary alloc]init];
    _array=[[NSMutableArray alloc]init];
    [self loadData];
}
-(void)loadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getOCFCLearnNavInfowithOCID:570
     FCID:175 finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
            _info =self.reob.resultObject;
            [self showCourseData];
            return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
-(void)showCourseData
{
    for (int i=0; i<_list.count; i++) {
        _dict=[NSMutableDictionary dictionaryWithCapacity:0];
        [_dict setObject:[NSNumber numberWithBool:YES] forKey:SECTION_STATE];
        [_array addObject:_dict];
    }
    [_tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _list.count;
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
    view.frame=CGRectMake(0, 0,self.view.frame.size.width , 50);
    view.backgroundColor=[UIColor orangeColor];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(30, 0, 320, 50)];
    lable.text=@"ASDFGH";
    [view addSubview:lable];
    UIButton *button=[[UIButton alloc]init];
    button.frame=CGRectMake(0, 0,self.view.frame.size.width , 50);
    button.backgroundColor=[UIColor clearColor];
    button.tag=section+100;
    [button addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellId=@"CELLID";
    UITableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:CellId];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
        
    }
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

-(void)pushMemberViewController
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
