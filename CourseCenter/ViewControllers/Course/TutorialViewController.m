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
#import "HWorkDetailWebViewController.h"
#import "DetailDataCell.h"
#import "FileInfo.h"
#import "PlayViewController.h"
#import "SectionAndRow.h"
#import "PICircularProgressView.h"
#import "MyPicViewController.h"
#define SECTION_STATE @"SECTION_STATE"
static NSInteger tag;
@interface TutorialViewController ()
{
    NSMutableArray *_array;
    NSMutableDictionary *_dict;
    NSMutableArray *_arrayData;
    NSMutableArray *_moocFileArray;
    NSMutableArray *_sectionArray;
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
@property (strong,nonatomic)NSString *filePath;
@property(nonatomic,assign)long openFileID;
@property(nonatomic, assign) long  openChapterID;
@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;
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
//进度条
@property(nonatomic,strong)PICircularProgressView *progress;
//选择的selectSection
@property(nonatomic,assign)NSInteger selectSection;
@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailDataCell" bundle:nil] forCellReuseIdentifier:@"DetailDataCell"];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.httpManager = [[CCHttpManager alloc]init];
    _array=[NSMutableArray arrayWithCapacity:0];
    _moocFileArray=[NSMutableArray arrayWithCapacity:0];
    _sectionArray=[NSMutableArray arrayWithCapacity:0];
    tag=0;
    self.fileArray=[[NSMutableArray alloc]init];
    [FileDownLoadManager sharedFilesDownManageWithBasepath:BASEPATH TargetPathArr:[NSArray arrayWithObject:[NSString stringWithFormat:@"%@/%@",BASEPATH,TARGER]]];
    [FileDownLoadManager sharedFilesDownManage].downloadDelegate=self;

    [self isTeacherOrStudent];
}
-(void)isTeacherOrStudent
{
//    role=[[NSUserDefaults standardUserDefaults]objectForKey:@"role"];
//    if (![role isEqualToString:@"4"]) {
//        self.tableView.hidden=YES;
//        _tishi.hidden=NO;
//    }else
//    {
        self.tableView.hidden=NO;
        _tishi.hidden=YES;
        [self loadData];
//    }
}
-(void)loadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getChapterStudyListwithOCID:self.OCID finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                _arrayData=self.reob.resultArray;
                [self showCourseData];
                [self addMoocFileArray];
               // [self loadOCMoocFile];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
-(void)loadData1
{
         //[MBProgressHUD showMessage:nil];
    [self.httpManager getChapterStudyListwithOCID:self.OCID finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                _arrayData=self.reob.resultArray;
                [self showCourseData];
                // [self loadOCMoocFile];
//                [self loadOCMoocFileWithSection:_selectSection WithIsBlock:YES];
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
-(void)addMoocFileArray
{
    for (int i=0; i<_arrayData.count; i++) {
         [_moocFileArray addObject:[NSMutableArray arrayWithArray:nil]];
    }
}
-(void)loadOCMoocFileWithSection:(NSInteger)section WithIsBlock:(BOOL)isBlock
{
//    if (tag==_arrayData.count) {
//        [MBProgressHUD hideHUD];
//        [self dataConvert];
//        return ;
//    }
    if (!isBlock) {
        for (NSNumber *num in _sectionArray) {
            if ([num integerValue]==section) {
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
                return;
            }
        }
    }
    long chapterID=((ChapterInfo *)[_arrayData objectAtIndex:section]).ChapterID;
    if (((ChapterInfo *)[_arrayData objectAtIndex:tag]).TestID<=0)
    {
        [MBProgressHUD showMessage:nil];
        [self.httpManager getOCMoocFileStudyListwithOCID:self.OCID ChapterID:chapterID FileType:-1 finished:^(EnumServerStatus status, NSObject *object) {
            [MBProgressHUD hideHUD];
            if (status==0) {
                self.reob=(ResponseObject *)object;
                if ([self.reob.errrorCode isEqualToString:@"0"]) {
                    //[_moocFileArray addObject:self.reob.resultArray];
                      _moocFileArray[section]=self.reob.resultArray;
                     [self dataConvert];
                    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
                    [_sectionArray addObject:[NSNumber numberWithInteger:section]];
//                    tag++;
//                    [self loadOCMoocFile];
                    return ;
                }
            }
            [MBProgressHUD showError:LOGINMESSAGE_F];
        }];
    }else
    {
//      [_moocFileArray addObject:[NSMutableArray arrayWithArray:nil]];
        _moocFileArray[section]=[NSMutableArray arrayWithArray:nil];
        [self dataConvert];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
//        tag++;
//        [self loadOCMoocFile];
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
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 50)];
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
   if (((ChapterInfo *)[_arrayData objectAtIndex:section]).ChapterRate!=-1)
    {
        _progress=[[PICircularProgressView alloc]init];
        _progress.frame=CGRectMake(_tableView.frame.size.width-50, 5, 40, 40);
        _progress.progress=(double)((ChapterInfo *)[_arrayData objectAtIndex:section]).ChapterRate/100;
        _progress.thicknessRatio=0.2;
        _progress.innerBackgroundColor=RGBA(255, 255, 255, 1);
        _progress.outerBackgroundColor=RGBA(255, 255, 255, 1);
        _progress.progressFillColor=RGBA(161, 210, 110, 1);
        _progress.textColor=RGBA(255, 96, 112, 1);
        [view addSubview:_progress];

    }
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
            cell.IsAllowStudy=info.IsAllowStudy;
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
            cell.IsAllowStudy=info.IsAllowStudy;
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
            cell.IsAllowStudy=info.IsAllowStudy;
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
            cell.IsAllowStudy=info.IsAllowStudy;
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
    [self loadOCMoocFileWithSection:but.tag-100 WithIsBlock:NO];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectSection=indexPath.section;
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
                playVC.isRecord=YES;
                playVC.OCID=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).OCID;
                playVC.ChapterID=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).ChapterID;
                playVC.FileID=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).FileID;
                playVC.Seconds=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).Seconds;
                playVC.pauseBlock = ^(NSInteger sends) {
                    ((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).Seconds = (int)sends;
                    [self loadData1];
                    [self loadOCMoocFileWithSection:indexPath.section WithIsBlock:YES];
                    
                };
//                playVC.tutorVC=self;
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
    }else if (((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).FileType==6) {
        MyPicViewController *picVC=[[MyPicViewController alloc]init];
        picVC.url=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).DownUrl;
        picVC.picName=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).FileTitle;;
        [((AppDelegate *)app).nav pushViewController:picVC animated:YES];
        [self loadData1];
        [self loadOCMoocFileWithSection:indexPath.section WithIsBlock:YES];
    }else
    {
        NSString * fileName=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).FileTitle;
        if ([[self isExistWithFileName:fileName] isEqualToString:@""]) {
            [Tool showAlertView:@"提示" withMessage:@"请先下载!" withTarget:self withCancel:@"确定" other:nil];
        }else
        {
            _filePath=[self isExistWithFileName:fileName];
            _openChapterID=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).ChapterID;
            _openFileID=((MoocFileInfo *)[[_moocFileArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).FileID;
          [Tool showAlertView:@"提示" withMessage:@"使用第三方软件打开该类型资源" withTarget:self withCancel:@"取消" other:@"确定"];
           // [self loadData1];
         //[self loadOCMoocFileWithSection:indexPath.section WithIsBlock:YES];
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
    FileModel *fileInfo=[request.userInfo objectForKey:@"File"];
    if (![fileInfo.fileType isEqualToString:@"1"]) {
       [self addStuFileWithChapterID:fileInfo.ChapterID fileID:fileInfo.fileID];
       [self loadData1];
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
    NSInteger num=((ChapterInfo *)[_arrayData objectAtIndex:but.tag-100]).IsAllowStudy;
    switch (num) {
        case 0:{
            [Tool showAlertView:@"提示" withMessage:@"请先学习前面的章节" withTarget:self withCancel:@"确定" other:nil];
            break;
        }
        case 1:{
            HWorkDetailWebViewController *hwdVC=[[HWorkDetailWebViewController alloc]init];
            hwdVC.TestID=((ChapterInfo *)[_arrayData objectAtIndex:but.tag-100]).TestID;
            hwdVC.popBlock=^(void)
            {
                [self loadData1];
            };
            [((AppDelegate *)app).nav pushViewController:hwdVC animated:YES];
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
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:_filePath]];
        self.documentInteractionController.delegate = self;
        CGRect navRect = self.navigationController.navigationBar.frame;
        navRect.size = CGSizeMake(1500.0f, 40.0f);
        [self.documentInteractionController presentOpenInMenuFromRect:navRect inView:self.view animated:YES];
        [self addStuFileWithChapterID:_openChapterID fileID:[NSString stringWithFormat:@"%ld",_openFileID]];
        [self loadData1];
        [self loadOCMoocFileWithSection:_selectSection WithIsBlock:YES];
    }
}
//判断文件是否存在 并返回 路径
-(NSString *)isExistWithFileName:(NSString *)fileName
{
    NSString *document = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *plistPath = [[document stringByAppendingPathComponent:BASEPATH]stringByAppendingPathComponent:@"finishPlist.plist"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:plistPath]) {
        NSMutableArray *finishArray = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
        for (NSDictionary *dic in finishArray) {
            if ([fileName isEqualToString:[dic objectForKey:@"filename"]]) {
                return [[[document stringByAppendingPathComponent:BASEPATH]stringByAppendingPathComponent:TARGER]stringByAppendingPathComponent:fileName];
            }
        }
        return @"";
    }
    return @"";
}
-(UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}
-(UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
    return self.view;
}
-(CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
    return self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


@end
