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
#import "GroupInfo.h"
#import "AFNetworking.h"
#import "UserInfo.h"
#define SECTION_STATE @"SECTION_STATE"
@interface NewMessage ()
{
    NSMutableArray *_array;
    NSMutableArray *_arrayData;
    NSMutableArray *_subArray;
    NSMutableDictionary *_dict;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (strong,nonatomic)GroupInfo *info;
@end

@implementation NewMessage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"新建消息";
    [self setupCustomRightWithtitle:@"确定" target:self action:@selector(sure)];
    self.httpManager = [[CCHttpManager alloc]init];
    _array=[NSMutableArray arrayWithCapacity:0];
    _subArray=[NSMutableArray arrayWithCapacity:0];
    _arrayData=[NSMutableArray arrayWithCapacity:0];
    ((AppDelegate *)app).dicData=[NSMutableDictionary dictionaryWithCapacity:0];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewMessageCell" bundle:nil] forCellReuseIdentifier:@"NewMessageCell"];
    [self aLoadData];
}
-(void)aLoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getOCClassListWithfinished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                _arrayData=self.reob.resultArray;
                [self showCourseData];
                [self initSelectState:NO];
                [_tableView reloadData];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
-(void)bLoadDataWithId:(NSString *)ID type:(NSString *)type
{
    NSString *partURL = [[[kServerIP stringByAppendingString:kServerPort] stringByAppendingString:kSerVerName] stringByAppendingString:kServiceName];
    NSString *URLString =[partURL stringByAppendingString:@"/Msg/App_ClassUser_List"];
    NSDictionary *parameters = @{@"ID": [NSNumber numberWithLong:53],@"Type": [NSNumber numberWithInt:1]};
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    NSMutableURLRequest *request = [requestSerializer requestWithMethod:@"GET" URLString:URLString parameters:parameters error:nil];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    [requestOperation setResponseSerializer:responseSerializer];
    [requestOperation start];
    [requestOperation waitUntilFinished];
    if ([[[requestOperation responseObject] objectForKey:@"errorCode"]isEqualToString:@"0"]) {
        [MBProgressHUD hideHUD];
       [_subArray addObject:[[requestOperation responseObject] objectForKey:@"result"]];
    }else
    {
       [MBProgressHUD hideHUD];
       [MBProgressHUD showError:LOGINMESSAGE_F];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[[NSBundle mainBundle]loadNibNamed:@"HeadForTable" owner:self options:nil]objectAtIndex:0];
    _head_title.text=((GroupInfo *)[_arrayData objectAtIndex:section]).Name;
    _head_btn_left.tag=section;
    _head_btn_right.tag=section+100;
    [_head_btn_right addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
    if ([self returnWithSection:section]) {
        _head_btn_left.selected=YES;
    }else
    {
        _head_btn_left.selected=NO;
    }
    return view;
}
-(void)press:(UIButton *)but
{
   // [self bLoadDataWithId:nil type:nil];
    NSMutableDictionary *dicto=[_array objectAtIndex:but.tag-100];
    NSNumber *num=[dicto objectForKey:SECTION_STATE];
    if ([num boolValue]) {
        [dicto setObject:[NSNumber numberWithBool:NO] forKey:SECTION_STATE];
    }else
    {
        [dicto setObject:[NSNumber numberWithBool:YES] forKey:SECTION_STATE];
    }
    [_tableView reloadData];
   // [_tableView reloadSections:[NSIndexSet indexSetWithIndex:but.tag-100] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)showCourseData
{
    
    for (int i=0; i<_arrayData.count; i++) {
        _dict=[NSMutableDictionary dictionaryWithCapacity:0];
        [_dict setObject:[NSNumber numberWithBool:YES] forKey:SECTION_STATE];
        [_array addObject:_dict];
    }
    for (int i=0; i<_arrayData.count; i++) {
        [self bLoadDataWithId:nil type:nil];
    }
    [MBProgressHUD hideHUD];
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
        return ((NSArray *)[_subArray objectAtIndex:section]).count;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewMessageCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"NewMessageCell"];
    cell.dic=((AppDelegate *)app).dicData;
    NSMutableArray *array=[_subArray objectAtIndex:indexPath.section];
    cell.indexPath=indexPath;
    cell.info=[array objectAtIndex:indexPath.row];
    return cell;
}
-(void)sure
{
    SendMesage *sendMessage=[[SendMesage alloc]
                             init];
    sendMessage.array=_subArray;
    [((AppDelegate *)app).nav pushViewController:sendMessage animated:YES];
}
- (IBAction)selectAll:(UIButton *)sender {
    static BOOL isOk=YES;
    if (isOk) {
        [sender setImage:[UIImage imageNamed:@"btn_confirm_hover"] forState:UIControlStateNormal
         ];
        [self initSelectState:YES];
    }else
    {
        [sender setImage:[UIImage imageNamed:@"btn_confirm"] forState:UIControlStateNormal
         ];
        [self initSelectState:NO];
    }
    isOk=!isOk;
    [_tableView reloadData];
}
- (IBAction)btn_left:(UIButton *)sender {
    sender.selected=!sender.selected;
    [self setSelectStateWith:sender.tag];
    [_tableView reloadData];
}
-(void)initSelectState:(BOOL)isAll
{
    NSString *select=@"SEL";
    NSString *noSelect=@"NOSEL";
    for (int i=0; i<_subArray.count; i++) {
        NSMutableArray *array=[[NSMutableArray alloc]init];
        NSArray *ar=[_subArray objectAtIndex:i];
        for (int j=0;j<ar.count;j++) {
            if (isAll) {
              [array addObject:select];
            }else
            {
               [array addObject:noSelect];
            }
        }
        [((AppDelegate *)app).dicData  setObject:array forKey:[NSString stringWithFormat:@"%d",i]];
    }
}
-(void)setSelectStateWith:(NSInteger)section
{
    NSString *select=@"SEL";
    NSString *noSelect=@"NOSEL";
    NSMutableArray *array=[((AppDelegate *)app).dicData objectForKey:[NSString stringWithFormat:@"%d",section]];
    for (int i=0;i<array.count; i++) {
        if (_head_btn_left.selected) {
            [((AppDelegate *)app).dicData objectForKey:[NSString stringWithFormat:@"%d",section]][i]=select;
        }else
        {
            [((AppDelegate *)app).dicData objectForKey:[NSString stringWithFormat:@"%d",section]][i]=noSelect;
        }
    }
}
-(BOOL)returnWithSection:(NSInteger)section
{
        NSMutableArray *array=[((AppDelegate *)app).dicData objectForKey:[NSString stringWithFormat:@"%d",section]];
        for (int j=0; j<array.count; j++) {
            if ([array[j] isEqualToString:@"NOSEL"]) {
                return NO;
            }
        }
    return YES;
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
