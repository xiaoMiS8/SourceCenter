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
    self.httpManager = [[CCHttpManager alloc]init];
     self.dataArray=[[NSMutableArray array]init];
    [self kLoadData];
}
//课程资料
-(void)kLoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getAppOCNameListWithrole:1 IsHistroy:NO finished:^(EnumServerStatus status, NSObject *object) {
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
//我的资料
-(void)mLoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getAppFileCountWithOCID:161 finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                 fileInfo=self.reob.resultObject;
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
        [_tableView reloadData];
    }
    else {
        [self mLoadData];
        [_tableView reloadData];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (seg.selectedSegmentIndex) {
        case 0:
            return _dataArray.count;
        case 1:
            return 4;
        default:
            return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier1 = @"cell1";
    static NSString *cellIndentifier2 = @"cell2";
    UITableViewCell *cell =seg.selectedSegmentIndex==0? [tableView dequeueReusableCellWithIdentifier:cellIndentifier1]:[tableView dequeueReusableCellWithIdentifier:cellIndentifier2];
    if (!cell) {
        cell =seg.selectedSegmentIndex==0?[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier1]:[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier2];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text =((OCourseInfo *)[_dataArray objectAtIndex:indexPath.row]).Name;
    if (seg.selectedSegmentIndex==1) {
        switch (indexPath.row) {
            case 0:
                cell.imageView.image=[UIImage imageNamed:@"icon_datum1"];
                cell.textLabel.text =[NSString stringWithFormat:@"全部资料 (%d)",fileInfo.AllCount];
                break;
            case 1:
                cell.imageView.image=[UIImage imageNamed:@"icon_document"];
                cell.textLabel.text =[NSString stringWithFormat:@"文稿资料 (%d)",fileInfo.ElseCount];
                break;
            case 2:
                cell.imageView.image=[UIImage imageNamed:@"icon_photo1"];
                cell.textLabel.text =[NSString stringWithFormat:@"图片资料 (%d)",fileInfo.PicCount];
                break;
            case 3:
                cell.imageView.image=[UIImage imageNamed:@"icon_video1"];
                cell.textLabel.text =[NSString stringWithFormat:@"视频资料 (%d)",fileInfo.VideoCount];
                break;
            default:
                break;
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (seg.selectedSegmentIndex==0) {
        CourseData *courseData=[[CourseData alloc]init];
        courseData.title=((OCourseInfo *)[_dataArray objectAtIndex:indexPath.row]).Name;
        [((AppDelegate *)app).nav pushViewController:courseData animated:YES];
    }else
    {
        DetailData *detailData=[[DetailData alloc]init];
        switch (indexPath.row) {
            case 0:
                detailData.title=@"全部资料";
                break;
            case 1:
                detailData.title=@"文稿资料";
                break;
            case 2:
                detailData.title=@"图片资料";
                break;
            case 3:
                detailData.title=@"视频资料";
                break;
            default:
                break;
        }
        [((AppDelegate *)app).nav pushViewController:detailData animated:YES];
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
