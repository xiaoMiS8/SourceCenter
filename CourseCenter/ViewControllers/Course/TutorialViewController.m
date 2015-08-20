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
#import "DetailDataCell.h"
#import "FileInfo.h"
#import "PlayViewController.h"
#import "SectionAndRow.h"
#define SECTION_STATE @"SECTION_STATE"
static NSInteger tag;
@interface TutorialViewController ()
{
    NSMutableArray *_array;
    NSMutableDictionary *_dict;
    NSMutableArray *_arrayData;
    NSMutableArray *_moocFileArray;
    NSString *role;
    //正在下载的文件 位置 列表
    NSMutableArray *downIngRow;
    //已经完成的文件 位置 列表
    NSMutableArray *finishRow;
    //未下载完成文件 位置 列表
    NSMutableArray *pauseRow;
}
@property (weak, nonatomic) IBOutlet UILabel *tishi;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
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

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailDataCell" bundle:nil] forCellReuseIdentifier:@"DetailDataCell"];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.httpManager = [[CCHttpManager alloc]init];
    _array=[NSMutableArray arrayWithCapacity:0];
    _moocFileArray=[NSMutableArray arrayWithCapacity:0];
    tag=0;
    self.fileArray=[[NSMutableArray alloc]init];
    [FileDownLoadManager sharedFilesDownManageWithBasepath:BASEPATH TargetPathArr:[NSArray arrayWithObject:[NSString stringWithFormat:@"%@/%@",BASEPATH,TARGER]]];
    [FileDownLoadManager sharedFilesDownManage].downloadDelegate=self;

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
        [self dataConvert];
        return ;
    }
    long chapterID=((ChapterInfo *)[_arrayData objectAtIndex:tag]).ChapterID;
    if (((ChapterInfo *)[_arrayData objectAtIndex:tag]).TestID<=0)
    {
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
    }else
    {
        [_moocFileArray addObject:[NSMutableArray arrayWithArray:nil]];
        tag++;
        [self loadOCMoocFile];
    }
}
-(void)dataConvert
{
    for(int j=0;j<_moocFileArray.count;j++)
    {
        for (int i=0; i<((NSMutableArray *)_moocFileArray[j]).count; i++) {
            FileModel *model=[[FileModel alloc]init];
            MoocFileInfo  *info=_moocFileArray[j][i];
            model.fileID=[@(info.FileID) stringValue] ;
            model.ChapterID=info.ChapterID;
            model.fileName=info.FileTitle;
            model.fileURL=info.ViewUrl;
            model.fileType=[@(info.FileType) stringValue];
            model.IsReadFinish=info.IsReadFinish;
            model.section=j;
            model.row=i;
            model.isFirstReceived=YES;
            [_fileArray addObject:model];
        }
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
                sdr.section=((FileModel *)_fileArray[i]).section;
                sdr.row=((FileModel *)_fileArray[i]).row;
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
                sdr.section=((FileModel *)_fileArray[i]).section;
                sdr.row=((FileModel *)_fileArray[i]).row;
                sdr.num=i;
                [finishRow addObject:sdr];
                ((FileModel *)_finishedList[j]).section=sdr.section;
                ((FileModel *)_finishedList[j]).row=sdr.row;
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
            NSString *jj=((FileModel *)_tempFileListLeave[j]).fileName ;
            if ([ii isEqualToString:jj]) {
                SectionAndRow *sdr=[[SectionAndRow alloc]init];
                sdr.section=((FileModel *)_fileArray[i]).section;
                sdr.row=((FileModel *)_fileArray[i]).row;
                sdr.num=i;
                [pauseRow addObject:sdr];
                ((FileModel *)_tempFileListLeave[j]).section=sdr.section;
                ((FileModel *)_tempFileListLeave[j]).row=sdr.row;
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
    }else
    {
        view.backgroundColor=[UIColor whiteColor];
    }
    title=((ChapterInfo *)[_arrayData objectAtIndex:section]).Title;
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
    DetailDataCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"DetailDataCell"];
    cell.parentVC=self;
    //正在下载的
    for(int i=0;i<downIngRow.count;i++)
    {
        if (((SectionAndRow *)downIngRow[i]).section==indexPath.section&&((SectionAndRow *)downIngRow[i]).row==indexPath.row) {
            int num=((SectionAndRow *)downIngRow[i]).num;
            ASIHTTPRequest *theRequest=_downlingList[num];
            if (theRequest==nil) {
                return cell=Nil;
            }
            FileModel *fileInfo=[theRequest.userInfo objectForKey:@"File"];
            NSInteger jj=((SectionAndRow *)downIngRow[i]).section;
            NSInteger ii=((SectionAndRow *)downIngRow[i]).row;
            MoocFileInfo  *info=_moocFileArray[jj][ii];
            fileInfo.IsReadFinish=info.IsReadFinish;
            cell.request = theRequest;
            cell.fileModel=fileInfo;
            cell.btn.hidden=NO;
            cell.isFirst=NO;
            return cell;
        }
    }
        //已经完成的
    for(int i=0;i<finishRow.count;i++)
    {
        if (((SectionAndRow *)finishRow[i]).section==indexPath.section&&((SectionAndRow *)finishRow[i]).row==indexPath.row) {
            int num=((SectionAndRow *)finishRow[i]).num;
            NSInteger jj=((SectionAndRow *)finishRow[i]).section;
            NSInteger ii=((SectionAndRow *)finishRow[i]).row;
            MoocFileInfo  *info=_moocFileArray[jj][ii];
            ((FileModel *)_fileArray[num]).IsReadFinish=info.IsReadFinish;
            cell.isFinish=@"YES";
            cell.btn.hidden=YES;
            cell.fileModel=_fileArray[num];
            cell.isFirst=NO;
            return cell;
        }
    }
    //暂停的
    for(int i=0;i<pauseRow.count;i++)
    {
        if (((SectionAndRow *)pauseRow[i]).section==indexPath.section&&((SectionAndRow *)pauseRow[i]).row==indexPath.row) {
            int num=((SectionAndRow *)pauseRow[i]).num;
            NSInteger jj=((SectionAndRow *)pauseRow[i]).section;
            NSInteger ii=((SectionAndRow *)pauseRow[i]).row;
            MoocFileInfo  *info=_moocFileArray[jj][ii];
            ((FileModel *)_fileArray[num]).IsReadFinish=info.IsReadFinish;
            cell.request = nil;
            cell.fileModel=_fileArray[num];
            //手动设置百分比，显示弧度
            [cell setPercent];
            cell.btn.hidden=NO;
            cell.isFirst=NO;
            return cell;
        }
    }
            //未下载的
            MoocFileInfo *info=(MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
            FileModel *model=[[FileModel alloc]init];
            model.fileID=[@(info.FileID) stringValue] ;
            model.ChapterID=info.ChapterID;
            model.fileName=info.FileTitle;
            model.fileURL=info.ViewUrl;
            model.fileType=[@(info.FileType) stringValue];
            model.IsReadFinish=info.IsReadFinish;
            model.isFirstReceived=YES;
            cell.request=nil;
            cell.fileModel=model;
            cell.size.text=@"未下载";
            cell.btn.hidden=NO;
            cell.isFirst=YES;
            return cell;

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
                MoocFileInfo *info=(MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
                if ([Tool isExistWithName:info.FileTitle]) {
                    playVC.isNSBundle=YES;
                    playVC.playUrl=[Tool getPathUrlWithName:info.FileTitle];
                }else
                {
                 playVC.playUrl=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).ViewUrl;
                }
                playVC.OCID=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).OCID;
                playVC.ChapterID=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).ChapterID;
                playVC.FileID=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).FileID;
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
-(void)startDownload:(ASIHTTPRequest *)request
{
    
}
-(void)updateCellProgress:(ASIHTTPRequest *)request
{
}
-(void)finishedDownload:(ASIHTTPRequest *)request
{
    [self changeFileState];
    FileModel *fileInfo=[request.userInfo objectForKey:@"File"];
    if (![fileInfo.fileType isEqualToString:@"1"]) {
       [self addStuFileWithChapterID:fileInfo.ChapterID fileID:fileInfo.fileID];
    }
}
-(void)addStuFileWithChapterID:(long)chapterid fileID:(NSString *)fileid
{
     __block typeof (self) myself =self;
    [self.httpManager addOCMoocStuFilewithChapterID:chapterid FileID:[fileid intValue] IsFinish:1 finished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            myself.reob=(ResponseObject *)object;
            if ([myself.reob.errrorCode isEqualToString:@"0"]) {
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
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
