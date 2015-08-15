//
//  MyData.m
//  CourseCenter
//
//  Created by 2345 on 15/7/18.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MyData.h"
#import "CourseData.h"
#import "DetailData.h"
#import "OCourseInfo.h"
#import "FileInfo.h"
#import "DetailDataCell.h"
@interface MyData ()
{
    UISegmentedControl *seg;
    OCourseInfo *oCourseInfo;
    FileInfo *fileInfo;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation MyData

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *array = @[@"课程资料",@"我的资料"];
    seg = [[UISegmentedControl alloc] initWithItems:array];
    seg.selectedSegmentIndex = 0;
    seg.bounds = CGRectMake(0, 0, 160, 30);
    [seg addTarget:self action:@selector(segValueChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = seg;
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailDataCell" bundle:nil] forCellReuseIdentifier:@"DetailDataCell"];
    self.httpManager = [[CCHttpManager alloc]init];
     self.dataArray=[[NSMutableArray array]init];
    [self kLoadData];
}
//课程资料
-(void)kLoadData
{
    int role=[[[NSUserDefaults standardUserDefaults]objectForKey:@"role"]intValue];
    if(role==4)
    {
        role=2;
    }else
    {
        role=1;
    }
    [MBProgressHUD showMessage:nil];
    [self.httpManager getAppOCNameListWithrole:role IsHistroy:-1 finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.dataArray=nil;
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
//我的资料
-(void)mLoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getAppFileSearchwithSearchkey:nil OCID:0 FileType:1 PageIndex:1 PageSize:INT_MAX finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.dataArray=nil;
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
- (void)segValueChange:(UISegmentedControl *)myseg {
    if (myseg.selectedSegmentIndex == 0) {
        [self kLoadData];
    }
    else {
        [self mLoadData];
    }
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
    if (seg.selectedSegmentIndex==0) {
        static NSString *cellIndentifier1 = @"cell1";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIndentifier1];
        if (!cell) {
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier1];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text =((OCourseInfo *)[_dataArray objectAtIndex:indexPath.row]).Name;
        return cell;
    }else
    {
        DetailDataCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"DetailDataCell"];
        cell.fileInfo=[_dataArray objectAtIndex:indexPath.row];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (seg.selectedSegmentIndex==0) {
        CourseData *courseData=[[CourseData alloc]init];
        courseData.title=((OCourseInfo *)[_dataArray objectAtIndex:indexPath.row]).Name;
        courseData.OCID=((OCourseInfo *)[_dataArray objectAtIndex:indexPath.row]).OCID;
        [self.navigationController pushViewController:courseData animated:YES];
    }else
    {
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (seg.selectedSegmentIndex==0) {
        return 44;
    }else
    {
        return 50;
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
