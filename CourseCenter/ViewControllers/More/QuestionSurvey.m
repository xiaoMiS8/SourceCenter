//
//  QuestionSurvey.m
//  CourseCenter
//
//  Created by 2345 on 15/8/7.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "QuestionSurvey.h"
#import "QuestionSurveyCell.h"
@interface QuestionSurvey ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) CCHttpManager *httpManager;
@property(nonatomic, strong) ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation QuestionSurvey

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *array = @[@"问卷调查",@"教学评价"];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:array];
    seg.selectedSegmentIndex = 0;
    seg.bounds = CGRectMake(0, 0, 160, 30);
    [seg addTarget:self action:@selector(segValueChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = seg;
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"QuestionSurveyCell" bundle:nil] forCellReuseIdentifier:@"QuestionSurveyCell"];
    self.httpManager = [[CCHttpManager alloc]init];
    self.dataArray=[[NSMutableArray array]init];
    [self wloadData];
}
-(void)wloadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getSurveyMyJoinListWithKey:@"1" OCID:0 finished:^(EnumServerStatus status, NSObject *object) {
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
    [MBProgressHUD hideHUD];
}
-(void)jloadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getSurveyToObjectWithSurveyID:239 finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.dataArray=nil;//self.reob.resultArray;
                [_tableView reloadData];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
    [MBProgressHUD hideHUD];
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
    QuestionSurveyCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"QuestionSurveyCell"];
    cell.info=[_dataArray objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(void)segValueChange:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex==0) {
        [self wloadData];
    }else
    {
        [self jloadData];
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
