//
//  TutorialViewController.m
//  CourseCenter
//
//  Created by jian on 15/7/25.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "TutorialViewController.h"
#import "TuorialDetailViewController.h"
#import "MoocFileInfo.h"
#import "HWorkDetailViewController.h"
#import "PlayViewController.h"
#define SECTION_STATE @"SECTION_STATE"
static NSInteger tag;
@interface TutorialViewController ()
{
    NSMutableArray *_array;
    NSMutableDictionary *_dict;
    NSMutableArray *_arrayData;
    NSMutableArray *_moocFileArray;
    NSString *role;
}
@property (weak, nonatomic) IBOutlet UILabel *tishi;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.httpManager = [[CCHttpManager alloc]init];
    _array=[NSMutableArray arrayWithCapacity:0];
    _moocFileArray=[NSMutableArray arrayWithCapacity:0];
    tag=0;
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
    [self.httpManager getChapterStudyListwithOCID:self.OCID finished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                _arrayData=self.reob.resultArray;
                [self showCourseData];
                [self loadOCMoocFile];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
-(void)showCourseData
{
    for (int i=0; i<_arrayData.count; i++) {
        _dict=[NSMutableDictionary dictionaryWithCapacity:0];
        [_dict setObject:[NSNumber numberWithBool:YES] forKey:SECTION_STATE];
        [_array addObject:_dict];
    }
    [_tableView reloadData];
}
-(void)loadOCMoocFile
{
    if (tag==_arrayData.count) {
        [MBProgressHUD hideHUD];
        return ;
    }
    long chapterID=((ChapterInfo *)[_arrayData objectAtIndex:tag]).ChapterID;
//    int  buildMode=((ChapterInfo *)[_arrayData objectAtIndex:tag]).BuildMode;
    [self.httpManager getOCMoocFileStudyListwithOCID:self.OCID ChapterID:chapterID FileType:-1 finished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                [_moocFileArray addObject:self.reob.resultArray];
                tag++;
                [self loadOCMoocFile];
            }
        }
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
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
        return ((NSMutableArray *)[_moocFileArray objectAtIndex:section]).count;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title=nil;
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0,_tableView.frame.size.width , 50);
    if (((ChapterInfo *)[_arrayData objectAtIndex:section]).ParentID==0) {
        view.backgroundColor=[UIColor lightGrayColor];
        title=[NSString stringWithFormat:@"%@(章)",((ChapterInfo *)[_arrayData objectAtIndex:section]).Title];
    }else
    {
        view.backgroundColor=[UIColor whiteColor];
        title=((ChapterInfo *)[_arrayData objectAtIndex:section]).Title;
    }
    view.layer.borderColor=RGBA(205, 205, 205, 1).CGColor;
    view.layer.borderWidth=0.5;
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, _tableView.frame.size.width-20, 50)];
    lable.font=Font_14;
    lable.text=title;
    [view addSubview:lable];
    UIButton *button=[[UIButton alloc]init];
    button.frame=CGRectMake(0, 0,_tableView.frame.size.width , 50);
    button.backgroundColor=[UIColor clearColor];
    button.tag=section+100;
    if (((ChapterInfo *)[_arrayData objectAtIndex:section]).TestID>0) {
        [button addTarget:self action:@selector(gotohwVC:) forControlEvents:UIControlEventTouchUpInside];
    }else
    {
        [button addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
    }
    [view addSubview:button];
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoocFileInfo *info=(MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
        UIButton *btnView=[[UIButton alloc]initWithFrame:CGRectMake(0, 10,40, cell.frame.size.height-20)];
        [btnView setBackgroundImage:[UIImage imageNamed:@"btn_download"] forState:UIControlStateNormal];
        cell.accessoryView=btnView;
    }
        cell.imageView.image=[UIImage imageNamed:@"btn_confirm"];
    [self picHandleWithCell:cell withFileType:info.FileType];
        cell.textLabel.font=Font_14;
        cell.textLabel.text =info.FileTitle;
    return cell;

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
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).FileType==1) {
        NSInteger num=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).IsAllowStudy;
        switch (num) {
            case 0:{
                [Tool showAlertView:@"提示" withMessage:@"请先学习前面的章节" withTarget:self withCancel:@"确定" other:nil];
                break;
            }
            case 1:{
                PlayViewController *playVC=[[PlayViewController alloc]init];
                playVC.playUrl=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).ViewUrl;
                [self presentViewController:playVC animated:YES completion:nil];
                break;
            }
            case 2:{
                [Tool showAlertView:@"提示" withMessage:@"还未到开始学习时间" withTarget:self withCancel:@"确定" other:nil];
                break;
            }
            case 3:{
                [Tool showAlertView:@"提示" withMessage:@"请先学习完前面的章节" withTarget:self withCancel:@"确定" other:nil];
                break;
            }
            case 4:{
                [Tool showAlertView:@"提示" withMessage:@"请先完成上一章的测试" withTarget:self withCancel:@"确定" other:nil];
                break;
            }
            case 5:{
                [Tool showAlertView:@"提示" withMessage:@"请先学习完该章节" withTarget:self withCancel:@"确定" other:nil];
                break;
            }
            case 6:{
                [Tool showAlertView:@"提示" withMessage:@"请先完成所有章节及测试" withTarget:self withCancel:@"确定" other:nil];
                break;
            }
            default:
                break;
        }
    }else
    {
        [Tool showAlertView:@"提示" withMessage:@"请使用第三方软件打开该类型资源" withTarget:self withCancel:@"确定" other:nil];
    }
}

-(void)gotohwVC:(UIButton *)but
{
    HWorkDetailViewController *hwdVC=[[HWorkDetailViewController alloc]init];
    [((AppDelegate *)app).nav pushViewController:hwdVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


@end
