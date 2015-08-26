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
#import "HWorkDetailWebViewController.h"
#import "BBsDetailViewController.h"
#import "FileInfo.h"
#import "PlayViewController.h"
#import "SectionAndRow.h"
#import "DetailDataCell.h"
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
    //正在下载的文件 位置 列表
    NSMutableArray *downIngRow;
    //已经完成的文件 位置 列表
    NSMutableArray *finishRow;
    //未下载完成文件 位置 列表
    NSMutableArray *pauseRow;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property(nonatomic, strong) NSArray *titles;
//正在下载的列表
@property(nonatomic) NSMutableArray *downlingList;
//已经完成的列表
@property(nonatomic) NSMutableArray *finishedList;
//临时文件的列表
@property(nonatomic,strong) NSMutableArray *tempFileList;
//未完成的列表
@property(nonatomic,strong) NSMutableArray *tempFileListLeave;
//文件对应大小
@property(nonatomic) NSMutableDictionary *fileNameDic;
//下载队列对象
@property (nonatomic, weak) ASINetworkQueue *queue;
//对象数组
@property(nonatomic,strong)NSMutableArray *fileArray;
@end

@implementation FCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCustomRightWithImage:[UIImage imageNamed:@"btn_class"] target:self action:@selector(pushMemberViewController)];
    [self.tableView registerNib:[UINib nibWithNibName:@"FCourseDetailOne" bundle:nil] forCellReuseIdentifier:@"FCourseDetailOne"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FCourseDetailLast" bundle:nil] forCellReuseIdentifier:@"FCourseDetailLast"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailDataCell" bundle:nil] forCellReuseIdentifier:@"DetailDataCell"];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.httpManager = [[CCHttpManager alloc]init];
    _dict=[[NSMutableDictionary alloc]init];
    _array=[[NSMutableArray alloc]init];
    self.fileArray=[[NSMutableArray alloc]init];
    [FileDownLoadManager sharedFilesDownManageWithBasepath:BASEPATH TargetPathArr:[NSArray arrayWithObject:[NSString stringWithFormat:@"%@/%@",BASEPATH,TARGER]]];
    [FileDownLoadManager sharedFilesDownManage].downloadDelegate=self;
    self.titles = @[@"小组信息",@"学习资料",@"作业测试",@"论题互动",@"线下课堂",@"互相评价",@"我的得分"];
    number=0;
    total=0;
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
            [self dataConvert];
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
-(void)dataConvert
{
    for (int i=0; i<_info.OCFCFileList.count; i++) {
        FileModel *model=[[FileModel alloc]init];
        _ocFileInfo=_info.OCFCFileList[i];
        model.fileID=[@(_ocFileInfo.FCFileID) stringValue] ;
        model.fileName=_ocFileInfo.FileTitle;
        model.fileURL=_ocFileInfo.DownUrl;
        model.fileType=[@(_ocFileInfo.FileType) stringValue];
        model.isFirstReceived=YES;
        [_fileArray addObject:model];
    }
    [self changeFileState];
}
-(void)viewWillDisappear:(BOOL)animated{
    FileDownLoadManager *filedownmanage=[FileDownLoadManager sharedFilesDownManage];
    [filedownmanage saveFinishedFile];
    for (int i=0;i<_downlingList.count;i++) {
        [(ASIHTTPRequest *)_downlingList[i] cancel];
    }
    [_downlingList removeAllObjects];
}

-(void)removeASIRequst:( ASIHTTPRequest*)request
{
    [_downlingList removeObject:request];
    
}
-(void)changeFileState
{
    FileDownLoadManager *filedownmanage=[FileDownLoadManager sharedFilesDownManage];
    _downlingList=filedownmanage.downinglist;
    _finishedList=filedownmanage.finishedlist;
    self.tempFileList=[filedownmanage getTempFiles];
    self.queue=filedownmanage.queue;
    self.tempFileListLeave=[self filterTempFile:_downlingList andTotalTempFile:_tempFileList];
    [self initDownFinishPause];
    [self.tableView reloadData];
}
-(void)initDownFinishPause
{
    [self getDownlingList];
    [self getFinishedList];
    [self getPauseList];
}
/**
 *	@brief	从所有临时文件中筛选出没有进入队列的，
 也就是上次没下载完需要续传的
 *
 *	@param 	downloadArray 	正在下载的文件
 *	@param 	totalTempArray 	所有的临时文件
 *
 *	@return	需要断点续传的文件
 */
-(NSMutableArray*)filterTempFile:(NSMutableArray *)downloadArray andTotalTempFile:(NSMutableArray *)totalTempArray

{
    NSMutableArray *downingArray=[[NSMutableArray alloc] init];
    NSMutableArray *fileterArray=[[NSMutableArray alloc] init];
    //获取正在下载的文件名称数组
    for(int j=0;j<downloadArray.count;j++)
    {
        ASIHTTPRequest *requst=[downloadArray objectAtIndex:j];
        FileModel *fModel=[requst.userInfo objectForKey:@"File"];
        [downingArray addObject:fModel.fileName];
        
    }
    //获取需要断线续传的文件modle数组
    for(int i=0;i<totalTempArray.count;i++)
    {
        FileModel *fileModel=[totalTempArray objectAtIndex:i];
        //地址比较
        if(![downingArray containsObject:fileModel.fileName])
        {
            [fileterArray addObject:fileModel];
        }
        
    }
    return fileterArray;
}
//获取正在下载文件 id
-(void)getDownlingList
{
    downIngRow=[[NSMutableArray alloc]init];
    for (int i=0; i<_fileArray.count; i++) {
        for (int j=0; j<_downlingList.count; j++) {
            NSString *ii=((FileModel *)_fileArray[i]).fileName;
            ASIHTTPRequest *requst=_downlingList[j];
            NSString *jj=((FileModel *)[requst.userInfo objectForKey:@"File"]).fileName;
            if ([ii isEqualToString:jj]) {
                SectionAndRow *sdr=[[SectionAndRow alloc]init];
                sdr.row=i;
                sdr.num=j;
                [downIngRow addObject:sdr];
            }
        }
    }
}
//获取已经完成文件 id
-(void)getFinishedList
{
    finishRow=[[NSMutableArray alloc]init];
    for (int i=0; i<_fileArray.count; i++) {
        for (int j=0; j<_finishedList.count; j++) {
            NSString *ii=((FileModel *)_fileArray[i]).fileName;
            NSString *jj=((FileModel *)_finishedList[j]).fileName;
            if ([ii isEqualToString:jj]) {
                SectionAndRow *sdr=[[SectionAndRow alloc]init];
                sdr.row=i;
                [finishRow addObject:sdr];
                _fileArray[i]=_finishedList[j];
                
            }
        }
    }
}
//获取暂停文件 id
-(void)getPauseList
{
    pauseRow=[[NSMutableArray alloc]init];
    for (int i=0; i<_fileArray.count; i++) {
        for (int j=0; j<_tempFileListLeave.count; j++) {
            NSString *ii=((FileModel *)_fileArray[i]).fileName;
            NSString *jj=((FileModel *)_tempFileListLeave[j]).fileName;
            if ([ii isEqualToString:jj]) {
                SectionAndRow *sdr=[[SectionAndRow alloc]init];
                sdr.row=i;
                [pauseRow addObject:sdr];
                _fileArray[i]=_tempFileListLeave[j];
            }
        }
    }
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
        DetailDataCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"DetailDataCell"];
        cell.parentVC=self;
        //正在下载的
        for(int i=0;i<downIngRow.count;i++)
        {
            if (((SectionAndRow *)downIngRow[i]).row==indexPath.row) {
                int num=((SectionAndRow *)downIngRow[i]).num;
                ASIHTTPRequest *theRequest=_downlingList[num];
                if (theRequest==nil) {
                    return cell=Nil;
                }
                FileModel *fileInfo=[theRequest.userInfo objectForKey:@"File"];
                cell.request = theRequest;
                cell.fileModel=fileInfo;
                cell.isFirst=NO;
                return cell;
            }
        }
        //已经完成的
        for (SectionAndRow *sar in finishRow) {
            if (sar.row==indexPath.row) {
                cell.isFinish=@"YES";
                cell.btn.hidden=YES;
                cell.fileModel=[_fileArray objectAtIndex:indexPath.row];
                cell.isFirst=NO;
                return cell;
            }
        }
        //暂停的
        for (SectionAndRow *sar in pauseRow) {
            if (sar.row==indexPath.row) {
                cell.request = nil;
                cell.fileModel=[_fileArray objectAtIndex:indexPath.row];
                //手动设置百分比，显示弧度
                [cell setPercent];
                cell.isFirst=NO;
                return cell;
            }
        }
        //未下载的
        cell.request=nil;
        cell.fileModel=[_fileArray objectAtIndex:indexPath.row];
        cell.size.text=@"未下载";
        cell.isFirst=YES;
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
    }else if (indexPath.section==1) {
        return 50;
    }else
    {
        return 44;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        HWorkDetailWebViewController *hwdVC=[[HWorkDetailWebViewController alloc]init];
        
        [self.navigationController pushViewController:hwdVC animated:YES];
    }else if(indexPath.section==3)
    {
        BBsDetailViewController *bbsDetailVC = [[BBsDetailViewController alloc] init];
        [self.navigationController pushViewController:bbsDetailVC animated:YES];
    }else if(indexPath.section==1)
    {
        if ([((FileModel *)[_fileArray objectAtIndex:indexPath.row]).fileType isEqualToString:@"1"]) {
            PlayViewController *playVC=[[PlayViewController alloc]init];
            playVC.playUrl=((FileModel *)[_fileArray objectAtIndex:indexPath.row]).fileURL;
            [self presentViewController:playVC animated:YES completion:nil];
        }else
        {
            [Tool showAlertView:@"提示" withMessage:@"请使用第三方软件打开该类型资源" withTarget:self withCancel:@"确定" other:nil];
        }
    }
}
-(void)startDownload:(ASIHTTPRequest *)request
{
    
}
-(void)updateCellProgress:(ASIHTTPRequest *)request
{
}
-(void)finishedDownload:(ASIHTTPRequest *)request
{
    [self changeFileState];
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
