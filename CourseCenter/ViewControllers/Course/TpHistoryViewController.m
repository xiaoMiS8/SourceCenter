//
//  TpHistoryViewController.m
//  CourseCenter
//
//  Created by muzhenhua on 15/8/5.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "TpHistoryViewController.h"
#import "TpHistoryCell.h"
@interface TpHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation TpHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"历史事务";
    [self.tableView registerNib:[UINib nibWithNibName:@"TpHistoryCell" bundle:nil] forCellReuseIdentifier:@"TpHistoryCell"];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.httpManager=[[CCHttpManager alloc]init];
    self.dataArray=[[NSMutableArray array]init];
    [self LoadData];
}

-(void)LoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getAffairsListWithType:1 OCID:self.OCID IsHistory:1 PageIndex:1 PageSize:INT_MAX
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
    TpHistoryCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"TpHistoryCell"];
    cell.info=[_dataArray objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
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
