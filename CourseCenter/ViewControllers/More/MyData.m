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
    // FileInfo *fileInfo;
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
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (strong,nonatomic)NSString *filePath;
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
    [FileDownLoadManager sharedFilesDownManageWithBasepath:BASEPATH TargetPathArr:[NSArray arrayWithObject:[NSString stringWithFormat:@"%@/%@",BASEPATH,TARGER]]];
    [FileDownLoadManager sharedFilesDownManage].downloadDelegate=self;
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
    [self.httpManager getAppFileSearchwithSearchkey:nil OCID:0 FileType:1 PageIndex:1 PageSize:INT_MAX finished:^(EnumServerStatus status, NSObject *object) {
        [MBProgressHUD hideHUD];
        if (status==0) {
            self.dataArray=nil;
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
        self.fileArray=[[NSMutableArray alloc]init];
    for (int i=0; i<_dataArray.count; i++) {
        FileModel *model=[[FileModel alloc]init];
        FileInfo  *info=_dataArray[i];
        model.fileID=[@(info.FileID) stringValue] ;
        model.fileName=info.FileTitle;
        model.fileURL=info.FileURL;
        model.fileType=[@(info.FileType) stringValue];
        model.IsReadFinish=YES;
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
            NSString *ii=((FileModel *)_fileArray[i]).fileID;
            ASIHTTPRequest *requst=_downlingList[j];
            NSString *jj=((FileModel *)[requst.userInfo objectForKey:@"File"]).fileID;
            if ([ii isEqualToString:jj]) {
                [downIngRow addObject:[NSNumber numberWithInt:i]];
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
            NSString *ii=((FileModel *)_fileArray[i]).fileID;
            NSString *jj=((FileModel *)_finishedList[j]).fileID;
            if ([ii isEqualToString:jj]) {
                _fileArray[i]=_finishedList[j];
                [finishRow addObject:[NSNumber numberWithInt:i]];
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
            NSString *ii=((FileModel *)_fileArray[i]).fileID;
            NSString *jj=((FileModel *)_tempFileListLeave[j]).fileID;
            if ([ii isEqualToString:jj]) {
                _fileArray[i]=_tempFileListLeave[j];
                [pauseRow addObject:[NSNumber numberWithInt:i]];
            }
        }
    }
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
    if (seg.selectedSegmentIndex==0) {
        return _dataArray.count;
    }else
    {
        return _fileArray.count;
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
        DetailDataCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"DetailDataCell"];
        cell.parentVC=self;
        //正在下载的
        for(int i=0;i<downIngRow.count;i++)
        {
            if ([downIngRow[i] integerValue]==indexPath.row) {
                ASIHTTPRequest *theRequest=_downlingList[i];
                if (theRequest==nil) {
                    return cell=Nil;
                }
                FileModel *fileInfo=[theRequest.userInfo objectForKey:@"File"];
                fileInfo.IsReadFinish=YES;
                cell.request = theRequest;
                cell.fileModel=fileInfo;
                cell.isFirst=NO;
                return cell;
            }
        }
        //已经完成的
        for (NSNumber *row in finishRow) {
            if ([row integerValue]==indexPath.row) {
                cell.isFinish=@"YES";
                cell.btn.hidden=YES;
                FileModel *fileInfo=[_fileArray objectAtIndex:indexPath.row];
                fileInfo.IsReadFinish=YES;
                cell.fileModel=fileInfo;
                cell.isFirst=NO;
                return cell;
            }
        }
        //暂停的
        for (NSNumber *row in pauseRow) {
            if ([row integerValue]==indexPath.row) {
                cell.request = nil;
                FileModel *fileInfo=[_fileArray objectAtIndex:indexPath.row];
                fileInfo.IsReadFinish=YES;
                cell.fileModel=fileInfo;
                //手动设置百分比，显示弧度
                [cell setPercent];
                cell.isFirst=NO;
                return cell;
            }
        }
        //未下载的
        cell.request=nil;
        FileModel *fileInfo=[_fileArray objectAtIndex:indexPath.row];
        fileInfo.IsReadFinish=YES;
        cell.fileModel=fileInfo;
        cell.size.text=@"未下载";
        cell.isFirst=YES;
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
        if ([((FileModel *)[_fileArray objectAtIndex:indexPath.row]).fileType isEqualToString:@"1"]) {
            PlayViewController *playVC=[[PlayViewController alloc]init];
            FileModel *info=((FileModel *)[_fileArray objectAtIndex:indexPath.row]);
            if ([Tool isExistWithName:info.fileName]) {
                playVC.isNSBundle=YES;
                playVC.playUrl=[Tool getPathUrlWithName:info.fileName];
            }else
            {
                playVC.playUrl=((FileModel *)[_fileArray objectAtIndex:indexPath.row]).fileURL;
            }
            [self presentViewController:playVC animated:YES completion:nil];
        }else
        {
            
            FileModel *info=((FileModel *)[_fileArray objectAtIndex:indexPath.row]);
            if ([[self isExistWithFileName:info.fileName] isEqualToString:@""]) {
                [Tool showAlertView:@"提示" withMessage:@"请先下载!" withTarget:self withCancel:@"确定" other:nil];
            }else
            {
                _filePath=[self isExistWithFileName:info.fileName];
                [Tool showAlertView:@"提示" withMessage:@"使用第三方软件打开该类型资源" withTarget:self withCancel:@"取消" other:@"确定"];
            }
            
        }
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
-(void)startDownload:(ASIHTTPRequest *)request
{
    
}
-(void)updateCellProgress:(ASIHTTPRequest *)request
{
}
-(void)finishedDownload:(ASIHTTPRequest *)request
{
    [self initDownFinishPause];
    [self changeFileState];
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
