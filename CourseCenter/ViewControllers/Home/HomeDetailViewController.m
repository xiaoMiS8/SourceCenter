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
#define SECTION_STATE @"SECTION_STATE"
#define ICONIMG @"iconpro"
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
    [self addTableViewheader];
    [self.tableView registerNib:[UINib nibWithNibName:@"CourseDetailCell" bundle:nil] forCellReuseIdentifier:@"CourseDetailCell"];
    self.httpManager = [[CCHttpManager alloc]init];
    _array=[NSMutableArray arrayWithCapacity:0];
    _arrayData=[NSMutableArray arrayWithCapacity:0];
    _moocFileArray=[NSMutableArray arrayWithCapacity:0];
    [self loadData];
}
-(void)loadData
{
    [self.httpManager getAppOCMoocGetWithOCID:self.OCID finished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                _teacherInfo=self.reob.resultObject;
                [self showteacherInfo:_teacherInfo];
            }
        }
    }];
    [self.httpManager getChapterStudyListwithOCID:self.OCID finished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                _arrayData=self.reob.resultArray;
                [self showCourseData];
                [self loadOCMoocFile];
            }
        }
    }];
}
-(void)showteacherInfo:(TeacherInfo *)info
{
    [self.teacherImage sd_setImageWithURL:[NSURL URLWithString:self.teacherImgUrl] placeholderImage:[UIImage imageNamed:ICONIMG]];
    //[self.StartDate setText:info.StartDate];
    [self.TeacherName setText:info.TeacherName];
    [self.OrganizationName setText:info.OrganizationName];
    //[self.Ranks setText:info.Ranks];
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
    for (int i=0; i<_arrayData.count; i++) {
        long chapterID=((ChapterInfo *)[_arrayData objectAtIndex:i]).ChapterID;
        int  buildMode=((ChapterInfo *)[_arrayData objectAtIndex:i]).BuildMode;
        [self.httpManager getOCMoocFileStudyListwithOCID:528 ChapterID:6820 FileType:buildMode finished:^(EnumServerStatus status, NSObject *object) {
            if (status==0) {
                self.reob=(ResponseObject *)object;
                if ([self.reob.errrorCode isEqualToString:@"0"]) {
                    [_moocFileArray addObject:self.reob.resultArray];
                }
            }
        }];
    }
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
    lable.text=@"课程章节";
    lable.font=Font_14;
    [view addSubview:lable];
    self.tableView.tableHeaderView = view;
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
   NSString *title=((ChapterInfo *)[_arrayData objectAtIndex:section]).Title;
    UIView *view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0,_tableView.frame.size.width , 50);
    view.backgroundColor=[UIColor whiteColor];
    view.layer.borderColor=RGBA(205, 205, 205, 1).CGColor;
    view.layer.borderWidth=0.5;
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, _tableView.frame.size.width-20, 50)];
    lable.font=Font_14;
    lable.text=title;//@"第一章 大熊猫的生活习性";
    [view addSubview:lable];
    UIButton *button=[[UIButton alloc]init];
    button.frame=CGRectMake(0, 0,_tableView.frame.size.width , 50);
    button.backgroundColor=[UIColor clearColor];
    button.tag=section+100;
    [button addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchUpInside];
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
    cell.mooFileInfo=[[_moocFileArray objectAtIndex:indexPath.row]objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayViewController *playVC=[[PlayViewController alloc]init];
    playVC.playUrl=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.row]objectAtIndex:indexPath.row]).ViewUrl;
    [self presentViewController:playVC animated:YES completion:nil];
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
//    NSLog(@"%d",but.tag-100);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
