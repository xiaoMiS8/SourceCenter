//
//  CourseDataDetailViewController.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/30.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "DetailData.h"
#import "DetailDataCell.h"
#import "FileInfo.h"
#import "PlayViewController.h"
#import "SectionAndRow.h"
@interface DetailData ()
{
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
@property (strong,nonatomic)NSMutableArray *dataArray;
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

@implementation DetailData

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailDataCell" bundle:nil] forCellReuseIdentifier:@"DetailDataCell"];
    self.httpManager = [[CCHttpManager alloc]init];
    self.dataArray = [[NSMutableArray alloc]init];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.fileArray=[[NSMutableArray alloc]init];
    [FileDownLoadManager sharedFilesDownManageWithBasepath:BASEPATH TargetPathArr:[NSArray arrayWithObject:[NSString stringWithFormat:@"%@/%@",BASEPATH,TARGER]]];
    [FileDownLoadManager sharedFilesDownManage].downloadDelegate=self;
    [self kLoadData];
}
-(void)kLoadData
{
    [MBProgressHUD showMessage:nil];
    [self.httpManager getAppFileSearchwithSearchkey:nil OCID:_OCID FileType:_FileType PageIndex:1 PageSize:INT_MAX finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.dataArray=self.reob.resultArray;
                [self dataConvert];
                [_tableView reloadData];
                return ;
            }
        }
        [MBProgressHUD showError:LOGINMESSAGE_F];
    }];
}
-(void)dataConvert
{
    for (int i=0; i<_dataArray.count; i++) {
        FileModel *model=[[FileModel alloc]init];
        FileInfo  *info=_dataArray[i];
        model.fileID=[@(info.FileID) stringValue] ;
        model.fileName=info.FileTitle;
        model.fileURL=info.FileURL;
        model.fileType=[@(info.FileType) stringValue];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _fileArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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
