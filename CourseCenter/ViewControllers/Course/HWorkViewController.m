//
//  HWorkViewController.m
//  CourseCenter
//
//  Created by jian on 15/7/25.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "HWorkViewController.h"
#import "HWorkCell.h"
#import "TestInfo.h"
#import "HWorkDetailViewController.h"
@interface HWorkViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation HWorkViewController
{
    TestInfo *info;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"HWorkCell" bundle:nil] forCellReuseIdentifier:@"HWorkCell"];
     self.tableView.tableFooterView=[[UIView alloc]init];
     self.httpManager = [[CCHttpManager alloc]init];
     self.dataArray=[[NSMutableArray array]init];
    [self wLoadData];
}
//未上交
-(void)wLoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getAppTestNotSumbitListWithOCID:self.OCID
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
//已上交
-(void)yLoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getAppTestInfoSumbitListWithOCID:self.OCID
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
    HWorkCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"HWorkCell"];
    if (_seg.selectedSegmentIndex==0) {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        cell.segSelectNum=1;
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    cell.info=[_dataArray objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)setSeg:(UISegmentedControl *)seg
{
    _seg = seg;
    [seg addTarget:self action:@selector(segValueChange:) forControlEvents:UIControlEventValueChanged];
}
- (void)segValueChange:(UISegmentedControl *)seg {
    if (seg.selectedSegmentIndex == 0) {
            [self wLoadData];
    }
    else {
            [self yLoadData];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_seg.selectedSegmentIndex==0)
    {
        HWorkDetailViewController *hwdVC=[[HWorkDetailViewController alloc]init];
        [self pushViewController:hwdVC];
    }
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
