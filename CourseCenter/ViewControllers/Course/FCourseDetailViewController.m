//
//  FCourseDetailViewController.m
//  CourseCenter
//
//  Created by muzhenhua on 15/8/3.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "FCourseDetailViewController.h"
#import "OCFCLearnNavInfo.h"
#import "FRankInfo.h"
#import "CGroupInfo.h"
#import "FCourseDetailOne.h"
#import "OCFCFileInfo.h"
#import "SourceInfo.h"
#import "FCourseDetailLast.h"
#import "GroupInfoViewController.h"
#define SECTION_STATE @"SECTION_STATE"
static NSInteger  number=0;
static NSInteger  total=0;
@interface FCourseDetailViewController ()
{
    NSMutableArray *_array;
    NSMutableDictionary *_dict;
    OCFCLearnNavInfo *_info;
    FRankInfo *_frInfo;
    CGroupInfo *_cgInfo;
    OCFCFileInfo *_ocFileInfo;
    SourceInfo *_sourceInfo;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property(nonatomic, strong) NSArray *titles;
@end

@implementation FCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCustomRightWithImage:[UIImage imageNamed:@"btn_class"] target:self action:@selector(pushMemberViewController)];
    [self.tableView registerNib:[UINib nibWithNibName:@"FCourseDetailOne" bundle:nil] forCellReuseIdentifier:@"FCourseDetailOne"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FCourseDetailLast" bundle:nil] forCellReuseIdentifier:@"FCourseDetailLast"];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.httpManager = [[CCHttpManager alloc]init];
    _dict=[[NSMutableDictionary alloc]init];
    _array=[[NSMutableArray alloc]init];
    self.titles = @[@"小组信息",@"学习资料",@"作业测试",@"论题互动",@"线下课堂",@"互相评价",@"我的得分"];
    number=0;
    [MBProgressHUD showMessage:nil];
    [self loadData];
    [self loadScore];
    [self loadGroupInfo];
}

-(void)loadData
{
    [self.httpManager getOCFCLearnNavInfowithOCID:self.OCID
     FCID:self.FCID finished:^(EnumServerStatus status, NSObject *object) {
         total+=1;
         if (total==3) {
             [MBProgressHUD hideHUD];
         }
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
        number=7;
    for (int i=0; i<number; i++) {
        _dict=[NSMutableDictionary dictionaryWithCapacity:0];
        [_dict setObject:[NSNumber numberWithBool:YES] forKey:SECTION_STATE];
        [_array addObject:_dict];
    }
    [_tableView reloadData];
}
-(void)loadScore
{
    [self.httpManager getAppOCFCScoreRankWithFCID:self.FCID finished:^(EnumServerStatus status, NSObject *object) {
         total+=1;
         if (total==3) {
             [MBProgressHUD hideHUD];
         }
     if (status==0) {
      self.reob=(ResponseObject *)object;
      if ([self.reob.errrorCode isEqualToString:@"0"]) {
          _frInfo=self.reob.resultObject;
          [_tableView reloadData];
          return ;
        }
     }
         [MBProgressHUD showError:LOGINMESSAGE_F];
   }];
}
-(void)loadGroupInfo
{
    [self.httpManager getAppFCGroupWithOCID:self.OCID
     FCID:self.FCID finished:^(EnumServerStatus status, NSObject *object) {
        total+=1;
        if (total==3) {
            [MBProgressHUD hideHUD];
        }
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                _cgInfo=self.reob.resultObject;
                [_tableView reloadData];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return number;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *di=[_array objectAtIndex:section];
    NSNumber *number=[di objectForKey:SECTION_STATE];
    if ([number boolValue]) {
        return 0;
    }else
    {
        switch (section)
        {
            case 0:
                return 1;
            case 1:
                return _info.OCFCFileList.count;
            case 2:
                return _info.OCFCTestList.count;
            case 3:
                return _info.OCFCForumTopicList.count;
            case 4:
                return _info.FCOfflineList.count;
            case 5:
                return _info.OCFCSurveyList.count;
            case 6:
                return 1;
            default:
                return 0;
        }
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0,_tableView.frame.size.width , 50);
    view.backgroundColor=[UIColor whiteColor];
    view.layer.borderColor=RGBA(205, 205, 205, 1).CGColor;
    view.layer.borderWidth=0.5;
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 50)];
    lable.font=Font_14;
    lable.text=_titles[section];
    [view addSubview:lable];
    UILabel *lable2=[[UILabel alloc]initWithFrame:CGRectMake(_tableView.frame.size.width-120, 0, 100, 50)];
    lable2.font=Font_14;
    lable2.textAlignment=NSTextAlignmentRight;
    [self setHeadTitle:lable2 withSection:section];
    [view addSubview:lable2];
    UIButton *button=[[UIButton alloc]init];
    button.frame=CGRectMake(0, 0,_tableView.frame.size.width , 50);
    button.backgroundColor=[UIColor clearColor];
    button.tag=section+100;
    [button addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    return view;
}
-(void)setHeadTitle:(UILabel *)lable withSection:(NSInteger)section
{
    switch (section) {
        case 0:
            lable.text=@"";
            break;
        case 1:
            lable.text=[NSString stringWithFormat:@"得分%.2f",_frInfo.grouprank.FileScore];
            break;
        case 2:
            lable.text=[NSString stringWithFormat:@"得分%.2f",_frInfo.grouprank.TestScore];
            break;
        case 3:
            lable.text=[NSString stringWithFormat:@"得分%.2f",_frInfo.grouprank.ForumScore];
            break;
        case 4:
            lable.text=[NSString stringWithFormat:@"得分%.2f",_frInfo.grouprank.OfflineScore];
            break;
        case 5:
            lable.text=[NSString stringWithFormat:@"得分%.2f",_frInfo.grouprank.EvaluationScore];
            break;
        case 6:
            lable.text=[NSString stringWithFormat:@"得分%.2f",_frInfo.grouprank.SigninScore];
            break;
        default:
            lable.text=@"";
            break;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        FCourseDetailOne *cell=[_tableView dequeueReusableCellWithIdentifier:@"FCourseDetailOne"];
        cell.cgInfo=_cgInfo;
        return cell;
    }else if (indexPath.section==1)
    {
        _ocFileInfo=_info.OCFCFileList[indexPath.row];
        static NSString *cellIndentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
            UIButton *btnView=[[UIButton alloc]initWithFrame:CGRectMake(0, 10,40, cell.frame.size.height-20)];
            [btnView setBackgroundImage:[UIImage imageNamed:@"btn_download"] forState:UIControlStateNormal];
            cell.accessoryView=btnView;
        }
        [self picHandleWithCell:cell withFileType:_ocFileInfo.FileType];
        cell.textLabel.font=Font_14;
        cell.textLabel.text =_ocFileInfo.FileTitle;
        return cell;
    }else if(indexPath.section==2||indexPath.section==3||indexPath.section==5)
    {
        if (indexPath.section==2) {
           _sourceInfo=_info.OCFCTestList[indexPath.row];
        }else if(indexPath.section==3){
           _sourceInfo=_info.OCFCForumTopicList[indexPath.row];
        }else if(indexPath.section==5){
           _sourceInfo=_info.OCFCSurveyList[indexPath.row];
        }
        NSString *CellId=@"CELLID";
        UITableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:CellId];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
        }
        if (_sourceInfo.IsFinish) {
        cell.imageView.image=[UIImage imageNamed:@"icon_check"];
        }else
        {
        cell.imageView.image=[UIImage imageNamed:@""];
        }
        cell.textLabel.text=_sourceInfo.Title;
        return cell;
    }else if(indexPath.section==4)
    {
        NSString *CellId=@"CELLID1";
        UITableViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:CellId];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
        }
        return cell;
    }else
    {
        FCourseDetailLast *cell=[_tableView dequeueReusableCellWithIdentifier:@"FCourseDetailLast"];
        cell.cgInfo=_cgInfo;
        cell.frInfo=_frInfo;
        return cell;
    }
}
-(void)picHandleWithCell:(UITableViewCell *)cell withFileType:(NSInteger )type
{
    if (type==1) {
        cell.imageView.image=[UIImage imageNamed:@"icon_video2"];
    }else if(type==2)
    {
        cell.imageView.image=[UIImage imageNamed:@"word"];
    }else if(type==3)
    {
        cell.imageView.image=[UIImage imageNamed:@"excel"];
    }else if(type==4)
    {
        cell.imageView.image=[UIImage imageNamed:@"ppt"];
    }else if(type==5)
    {
        cell.imageView.image=[UIImage imageNamed:@"pdf"];
    }else if(type==6)
    {
        cell.imageView.image=[UIImage imageNamed:@"icon_photo"];
    }else if(type==7)
    {
        cell.imageView.image=[UIImage imageNamed:@"other"];
    }else if(type==8)
    {
        cell.imageView.image=[UIImage imageNamed:@"icon_document1"];
    }else if(type==9)
    {
        cell.imageView.image=[UIImage imageNamed:@"other"];
    }
    
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 90;
    }else if (indexPath.section==6) {
        return 202;
    }else
    {
        return 44;
    }
}
-(void)pushMemberViewController
{
    GroupInfoViewController *groupInfo=[[GroupInfoViewController alloc]init];
    groupInfo.OCID=self.OCID;
    groupInfo.FCID=self.FCID;
    [self.navigationController pushViewController:groupInfo animated:YES];
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
