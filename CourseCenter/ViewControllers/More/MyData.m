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
#import "PlayViewController.h"
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
    [self.httpManager getAppOCNameListWithrole:role IsHistroy:0 finished:^(EnumServerStatus status, NSObject *object) {
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
    [self.httpManager getAppFileCountWithOCID:0 finished:^(EnumServerStatus status, NSObject *object) {
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
    if (seg.selectedSegmentIndex == 0) {
        return _dataArray.count;
    }
    else {
        return 4;
    }
    
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
        static NSString *cellIndentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (!cell) {
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
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
        DetailData *detailData= [[DetailData alloc]init];
        detailData.OCID=0;
        switch (indexPath.row) {
            case 0:
                detailData.FileType=-1;
                detailData.title=@"全部资料";
                break;
            case 1:
                detailData.FileType=-2;
                detailData.title=@"文稿资料";
                break;
            case 2:
                detailData.FileType=6;
                detailData.title=@"图片资料";
                break;
            case 3:
                detailData.FileType=1;
                detailData.title=@"视频资料";
                break;
            default:
                break;
        }
        [self.navigationController pushViewController:detailData animated:YES];
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
