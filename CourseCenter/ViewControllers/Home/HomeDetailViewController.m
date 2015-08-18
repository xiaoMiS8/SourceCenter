//
//  HomeDetailViewController.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/26.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "CourseDetailCell.h"
#import "ResponseObject.h"
#import "TeacherInfo.h"
#import "ChapterInfo.h"
#import "PlayViewController.h"
#import "UIImageView+WebCache.h"
#import "ApplyViewController.h"
#import "NSString+HandleString.h"
#import "HWorkDetailViewController.h"
#import "TutorialViewController.h"
#define SECTION_STATE @"SECTION_STATE"
#define ICONIMG @"iconpro"
static NSInteger tag;
@interface HomeDetailViewController ()
{
    NSMutableArray *_array;
    NSMutableArray *_arrayData;
    NSMutableArray *_moocFileArray;
    NSMutableDictionary *_dict;
    TeacherInfo *_teacherInfo;
    ChapterInfo *_chapterInfo;
}
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIView *oneV;
@property (weak, nonatomic) IBOutlet UIView *twoV;
@property (weak, nonatomic) IBOutlet UIView *threeV;
@property (weak, nonatomic) IBOutlet UILabel *StartDate;
@property (weak, nonatomic) IBOutlet UILabel *TeacherName;
@property (weak, nonatomic) IBOutlet UILabel *OrganizationName;
@property (weak, nonatomic) IBOutlet UILabel *Ranks;
@property (weak, nonatomic) IBOutlet UILabel *AllPlayDay;
@property (weak, nonatomic) IBOutlet UIImageView *teacherImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) CGFloat startY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"课程";
    self.oneV.layer.borderColor=RGBA(205, 205, 205, 1).CGColor;
    self.oneV.layer.borderWidth=1;
    self.twoV.layer.borderColor=RGBA(205, 205, 205, 1).CGColor;
    self.twoV.layer.borderWidth=1;
    self.threeV.layer.borderColor=RGBA(205, 205, 205, 1).CGColor;
    self.threeV.layer.borderWidth=1;
    [self addTableViewFoot];
    [self.tableView registerNib:[UINib nibWithNibName:@"CourseDetailCell" bundle:nil] forCellReuseIdentifier:@"CourseDetailCell"];
    self.httpManager = [[CCHttpManager alloc]init];
    _array=[NSMutableArray arrayWithCapacity:0];
    _arrayData=[NSMutableArray arrayWithCapacity:0];
    _moocFileArray=[NSMutableArray arrayWithCapacity:0];
    tag=0;
    [self loadData];
}
-(void)loadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getAppOCMoocGetWithOCID:self.OCID finished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                _teacherInfo=self.reob.resultObject;
                [self showteacherInfo:_teacherInfo];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
    [self.httpManager getChapterStudyListwithOCID:self.OCID finished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                _arrayData=self.reob.resultArray;
                [self addTableViewheader];
                [self showCourseData];
                [self loadOCMoocFile];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
-(void)showteacherInfo:(TeacherInfo *)info
{
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:_topImgUrl] placeholderImage:[UIImage imageNamed:NOPIC]];
    [self.teacherImage sd_setImageWithURL:[NSURL URLWithString:self.teacherImgUrl] placeholderImage:[UIImage imageNamed:ICONIMG]];
    [self.StartDate setText:[info.StartDate carveNSStringWithStr:@" "][0]];
    [self.TeacherName setText:info.TeacherName];
    [self.OrganizationName setText:info.OrganizationName];
    [self.Ranks setText:info.Ranks];
    [self.AllPlayDay setText:[NSString stringWithFormat:@"%ld周",info.AllPlayDay]];
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
- (void)addTableViewheader
{

        UIView *view = [UIView new];
        view.bounds = CGRectMake(0, 0, 0, 30);
        view.layer.borderColor=RGBA(205, 205, 205, 1).CGColor;
        view.layer.borderWidth=1;
        view.backgroundColor = [UIColor whiteColor];
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(35, 2.5, 25, 25)];
        image.image=[UIImage imageNamed:@"icon_catalog"];
        [view addSubview:image];
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(image.frame.origin.x+image.frame.size.width+30, 0, 100, 30)];
        lable.font=Font_14;
        [view addSubview:lable];
        self.tableView.tableHeaderView = view;
    if(_arrayData.count!=0)
    {
        lable.text=@"课程章节";
    }else
    {
        lable.text=@"该课程暂无章节";
    }
    
}
-(void)addTableViewFoot
{
    UIView *view = [UIView new];
    view.bounds = CGRectMake(0, 0, 0, 50);
    view.backgroundColor = [UIColor whiteColor];
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake((Swidth-100)/2, 10, 100, 30)];
    if (_RegStatus==1) {
        [btn setTitle:@"去学习" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(gotoTutorial) forControlEvents:UIControlEventTouchUpInside];
         btn.tag=1;
         btn.hidden=NO;
    }else if (_RegStatus==2||_RegStatus==4) {
        [btn setTitle:@"报名" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sign) forControlEvents:UIControlEventTouchUpInside];
         btn.tag=2;
         btn.hidden=NO;
    }else
    {
        btn.hidden=YES;
    }
    [btn setTintColor:[UIColor whiteColor]];
    [btn setBackgroundColor:RGBA(31, 187, 255, 1)];
    btn.layer.masksToBounds=YES;
    btn.layer.cornerRadius=5;
    [view addSubview:btn];
    self.tableView.tableFooterView = view;
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     CourseDetailCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"CourseDetailCell"];
    cell.mooFileInfo=[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    return cell;
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
-(void)gotohwVC:(UIButton *)but
{
    HWorkDetailViewController *hwdVC=[[HWorkDetailViewController alloc]init];
    [((AppDelegate *)app).nav pushViewController:hwdVC animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY - _startY > 140) {
        [UIView animateWithDuration:1 animations:^{
            self.topConstraint.constant=-140;
        }];
    }
    else if (offsetY - _startY < -140)
    {
        [UIView animateWithDuration:1 animations:^{
            self.topConstraint.constant=0;
        }];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.startY = scrollView.contentOffset.y;
}
-(void)sign
{
    ApplyViewController *applyVc = [[ApplyViewController alloc]init];
    applyVc.OCID=_OCID;
    [((AppDelegate *)app).nav pushViewController:applyVc animated:YES];
}
-(void)gotoTutorial
{
    TutorialViewController *tutoriaVC = [[TutorialViewController alloc] init];
    tutoriaVC.title=@"教程";
    tutoriaVC.OCID=_OCID;
    [((AppDelegate *)app).nav pushViewController:tutoriaVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
