//
//  FCourseViewController.m
//  CourseCenter
//
//  Created by jian on 15/7/25.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "FCourseViewController.h"
#import "FCourseCell.h"
#import "FCourseInfo.h"
#import "FCourseDetailViewController.h"
@interface FCourseViewController ()
{
    FCourseInfo *info;
    NSString *role;
}

@property (weak, nonatomic) IBOutlet UILabel *tishi;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation FCourseViewController
{
    FCourseDetailViewController *fCourseDetailVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"FCourseCell" bundle:nil] forCellReuseIdentifier:@"FCourseCell"];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.httpManager=[[CCHttpManager alloc]init];
    self.dataArray=[[NSMutableArray array]init];
    fCourseDetailVC=[[FCourseDetailViewController alloc]init];
    [self isTeacherOrStudent];
}

-(void)isTeacherOrStudent
{
    role=[[NSUserDefaults standardUserDefaults]objectForKey:@"role"];
    if (![role isEqualToString:@"4"]) {
        self.tableView.hidden=YES;
        _tishi.hidden=NO;
    }else
    {
        self.tableView.hidden=NO;
        _tishi.hidden=YES;
        [self loadData];
    }
}
-(void)loadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getAppOCFCListWithOCID:self.ocourse.OCID
    finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"])
            {
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FCourseCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"FCourseCell"];
    cell.info=[_dataArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击松开后,颜色恢复
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    fCourseDetailVC.title=((FCourseInfo *)[_dataArray objectAtIndex:indexPath.row]).Title;
    fCourseDetailVC.OCID=self.ocourse.OCID;
    fCourseDetailVC.FCID=((FCourseInfo *)[_dataArray objectAtIndex:indexPath.row]).FCID;
    [self pushViewController:fCourseDetailVC];
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
