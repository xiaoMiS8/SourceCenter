//
//  TPViewController.m
//  CourseCenter
//
//  Created by jian on 15/7/25.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "TPViewController.h"
#import "TPViewCell.h"
#import "AffairInfo.h"
#import "TpHistoryViewController.h"
@interface TPViewController ()
{
    NSString *role;
}

@property (weak, nonatomic) IBOutlet UILabel *tishi;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation TPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"事务处理";
    [self.tableView registerNib:[UINib nibWithNibName:@"TPViewCell" bundle:nil] forCellReuseIdentifier:@"TPViewCell"];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.httpManager = [[CCHttpManager alloc]init];
    self.dataArray=[[NSMutableArray array]init];
    [self isTeacherOrStudent];
}

-(void)isTeacherOrStudent
{
    role=[[NSUserDefaults standardUserDefaults]objectForKey:@"role"];
    if ([role isEqualToString:@"4"]) {
        self.tableView.hidden=YES;
        _tishi.hidden=NO;
    }else
    {
        self.tableView.hidden=NO;
        _tishi.hidden=YES;
        [self LoadData];
    }
}
-(void)LoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getAffairsListWithType:1 OCID:161 IsHistory:-1 PageIndex:1 PageSize:INT_MAX
        finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.dataArray=self.reob.resultArray;
                [_tableView reloadData];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"TPViewCell"];
    cell.tableView=tableView;
    cell.info=[_dataArray objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175;
}
- (void)setRightBtn:(UIButton *)rightBtn {
    _rightBtn = rightBtn;
    [rightBtn setImage:[UIImage imageNamed:@"btn_history"] forState:UIControlStateNormal];
    [rightBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)rightBtnAction:(id)sender {
    if ([role isEqualToString:@"4"]) {
        [Tool showAlertView:@"提示" withMessage:@"此功能暂未对学生开放,敬请期待!" withTarget:self withCancel:@"确定" other:nil];
    }else
    {
        TpHistoryViewController *tpVC=[[TpHistoryViewController alloc]init];
        [self pushViewController:tpVC];
    }
    
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
