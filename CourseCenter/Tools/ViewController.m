////
////  ViewController.m
////  ZHResume
////
////  Created by muzhenhua on 15/8/12.
////  Copyright (c) 2015年 muzhenhua. All rights reserved.
////
//
//#import "ViewController.h"
//#import "MyViewCell.h"
//@interface ViewController ()
//{
//    //文件名称数组
//    NSMutableArray *fileNames;
//    //文件url数组
//    NSMutableArray *fileUrls;
//    //文件ID
//    NSMutableArray *fileId;
//    //正在下载的文件 位置 列表
//    NSMutableArray *downIngRow;
//    //已经完成的文件 位置 列表
//    NSMutableArray *finishRow;
//    //未下载完成文件 位置 列表
//    NSMutableArray *pauseRow;
//    
//}
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
////正在下载的列表
//@property(nonatomic) NSMutableArray *downlingList;
////已经完成的列表
//@property(nonatomic) NSMutableArray *finishedList;
////临时文件的列表
//@property(nonatomic,strong) NSMutableArray *tempFileList;
////未完成的列表
//@property(nonatomic,strong) NSMutableArray *tempFileListLeave;
////文件对应大小
//@property(nonatomic) NSMutableDictionary *fileNameDic;
////下载队列对象
//@property (nonatomic, weak) ASINetworkQueue *queue;
////对象数组
//@property(nonatomic,strong)NSMutableArray *fileArray;
//@end
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    [self.tableView registerNib:[UINib nibWithNibName:@"MyViewCell" bundle:nil] forCellReuseIdentifier:@"MyViewCell"];
//    _fileArray=[[NSMutableArray alloc]init];
//    [FileDownLoadManager sharedFilesDownManageWithBasepath:BASEPATH TargetPathArr:[NSArray arrayWithObject:[NSString stringWithFormat:@"%@/%@",BASEPATH,TARGER]]];
//    [FileDownLoadManager sharedFilesDownManage].downloadDelegate=self;
//    fileId=[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
//    fileNames = [[NSMutableArray alloc]initWithObjects:@"QQ",@"微信",@"微博",@"QQ音乐",@"英雄联盟",@"CF",@"地下城",@"随心贷",@"2345",@"北京", nil];
//    fileUrls = [[NSMutableArray alloc]initWithObjects:
//                @"http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.0.3.dmg",
//                @"http://dldir1.qq.com/qqfile/QQIntl/QQi_PC/QQIntl2.11.exe",
//                @"http://dldir1.qq.com/qqfile/QQIntl/QQi_wireless/Android/qqi_4.6.13.6034_office.apk",
//                @"http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.0.3.dmg",
//                @"http://dldir1.qq.com/qqfile/QQIntl/QQi_PC/QQIntl2.11.exe",
//                @"http://dldir1.qq.com/qqfile/QQIntl/QQi_wireless/Android/qqi_4.6.13.6034_office.apk",
//                @"http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.0.3.dmg",
//                @"http://dldir1.qq.com/qqfile/QQIntl/QQi_PC/QQIntl2.11.exe",
//                @"http://dldir1.qq.com/qqfile/QQIntl/QQi_wireless/Android/qqi_4.6.13.6034_office.apk",
//                @"http://dldir1.qq.com/qqfile/QQIntl/QQi_PC/QQIntl2.11.exe",nil];
//    for (int i=0; i<10; i++) {
//        FileModel *info=[[FileModel alloc]init];
//        info.fileID=fileId[i];
//        info.fileName=fileNames[i];
//        info.fileURL=fileUrls[i];
//        info.isFirstReceived=YES;
//        [_fileArray addObject:info];
//    }
//    
//}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [self loadData];
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    FileDownLoadManager *filedownmanage=[FileDownLoadManager sharedFilesDownManage];
//    [filedownmanage saveFinishedFile];
//}
//
//-(void)removeASIRequst:( ASIHTTPRequest*)request
//{
//    [_downlingList removeObject:request];
//    
//}
//-(void)loadData
//{
//    FileDownLoadManager *filedownmanage=[FileDownLoadManager sharedFilesDownManage];
//    _downlingList=filedownmanage.downinglist;
//    _finishedList=filedownmanage.finishedlist;
//    self.fileNameDic=filedownmanage.fileNameDic;
//    self.tempFileList=[filedownmanage getTempFiles];
//    self.queue=filedownmanage.queue;
//    self.tempFileListLeave=[self filterTempFile:_downlingList andTotalTempFile:_tempFileList];
//    [self initDownFinishPause];
//    [self.tableView reloadData];
//}
//-(void)initDownFinishPause
//{
//    [self getDownlingList];
//    [self getFinishedList];
//    [self getPauseList];
//}
///**
// *	@brief	从所有临时文件中筛选出没有进入队列的，
//            也就是上次没下载完需要续传的
// *
// *	@param 	downloadArray 	正在下载的文件
// *	@param 	totalTempArray 	所有的临时文件
// *
// *	@return	需要断点续传的文件
// */
//-(NSMutableArray*)filterTempFile:(NSMutableArray *)downloadArray andTotalTempFile:(NSMutableArray *)totalTempArray
//
//{
//    NSMutableArray *downingArray=[[NSMutableArray alloc] init];
//    NSMutableArray *fileterArray=[[NSMutableArray alloc] init];
//    //获取正在下载的文件名称数组
//    for(int j=0;j<downloadArray.count;j++)
//    {
//        ASIHTTPRequest *requst=[downloadArray objectAtIndex:j];
//        FileModel *fModel=[requst.userInfo objectForKey:@"File"];
//        [downingArray addObject:fModel.fileName];
//        
//    }
//    //获取需要断线续传的文件modle数组
//    for(int i=0;i<totalTempArray.count;i++)
//    {
//        FileModel *fileModel=[totalTempArray objectAtIndex:i];
//        //地址比较
//        if(![downingArray containsObject:fileModel.fileName])
//        {
//            [fileterArray addObject:fileModel];
//        }
//        
//    }
//    return fileterArray;
//}
////获取正在下载文件 id
//-(void)getDownlingList
//{
//    downIngRow=[[NSMutableArray alloc]init];
//    for (int i=0; i<_fileArray.count; i++) {
//        for (int j=0; j<_downlingList.count; j++) {
//            NSString *ii=((FileModel *)_fileArray[i]).fileID;
//            ASIHTTPRequest *requst=_downlingList[j];
//            NSString *jj=((FileModel *)[requst.userInfo objectForKey:@"File"]).fileID;
//            if ([ii isEqualToString:jj]) {
//                [downIngRow addObject:[NSNumber numberWithInt:i]];
//            }
//        }
//    }
//}
////获取已经完成文件 id
//-(void)getFinishedList
//{
//    finishRow=[[NSMutableArray alloc]init];
//    for (int i=0; i<_fileArray.count; i++) {
//        for (int j=0; j<_finishedList.count; j++) {
//            NSString *ii=((FileModel *)_fileArray[i]).fileID;
//            NSString *jj=((FileModel *)_finishedList[j]).fileID;
//            if ([ii isEqualToString:jj]) {
//                _fileArray[i]=_finishedList[j];
//                [finishRow addObject:[NSNumber numberWithInt:i]];
//            }
//        }
//    }
//}
////获取暂停文件 id
//-(void)getPauseList
//{
//    pauseRow=[[NSMutableArray alloc]init];
//    for (int i=0; i<_fileArray.count; i++) {
//        for (int j=0; j<_tempFileListLeave.count; j++) {
//            NSString *ii=((FileModel *)_fileArray[i]).fileID;
//            NSString *jj=((FileModel *)_tempFileListLeave[j]).fileID;
//            if ([ii isEqualToString:jj]) {
//                _fileArray[i]=_tempFileListLeave[j];
//                [pauseRow addObject:[NSNumber numberWithInt:i]];
//            }
//        }
//    }
//}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return _fileArray.count;
//}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    MyViewCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"MyViewCell"];
//    cell.parentVC=self;
//    //正在下载的
//    for(int i=0;i<downIngRow.count;i++)
//    {
//        if ([downIngRow[i] integerValue]==indexPath.row) {
//            ASIHTTPRequest *theRequest=_downlingList[i];
//            if (theRequest==nil) {
//                return cell=Nil;
//            }
//            FileModel *fileInfo=[theRequest.userInfo objectForKey:@"File"];
//            cell.request = theRequest;
//            cell.fileModel=fileInfo;
//            cell.isFirst=NO;
//            return cell;
//        }
//    }
//    //已经完成的
//    for (NSNumber *row in finishRow) {
//        if ([row integerValue]==indexPath.row) {
//            cell.isFinish=@"YES";
//            cell.btn.hidden=YES;
//            cell.fileModel=[_fileArray objectAtIndex:indexPath.row];
//            cell.isFirst=NO;
//            return cell;
//        }
//    }
//    //暂停的
//    for (NSNumber *row in pauseRow) {
//        if ([row integerValue]==indexPath.row) {
//            cell.request = nil;
//            cell.fileModel=[_fileArray objectAtIndex:indexPath.row];
//            //手动设置百分比，显示弧度
//            [cell setPercent];
//            cell.isFirst=NO;
//            return cell;
//        }
//    }
//    //未开始下载的
//        cell.request=nil;
//        cell.fileModel=[_fileArray objectAtIndex:indexPath.row];
//        cell.label2.text=@"未开始下载";
//        cell.isFirst=YES;
//        return cell;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 60;
//}
//
//-(void)startDownload:(ASIHTTPRequest *)request
//{
//    
//}
//-(void)updateCellProgress:(ASIHTTPRequest *)request
//{
//}
//-(void)finishedDownload:(ASIHTTPRequest *)request
//{
//    [self initDownFinishPause];
//    [self loadData];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//@end
