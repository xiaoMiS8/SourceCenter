//
//  FileDownLoadManager.m
//  BKResume
//
//  Created by muzhenhua on 15/8/10.
//  Copyright (c) 2015年 muzhenhua. All rights reserved.
//

#import "FileDownLoadManager.h"
#import "FileModel.h"
#import "CommonHelper.h"
@interface FileDownLoadManager()
@property(nonatomic,strong)FileModel *fileInfo;
@property(nonatomic,strong)NSString *basePath;//根路径名
@property(nonatomic,retain)NSString *TargetSubPath;//目标文件名
@property(nonatomic,strong)NSMutableArray  *targetPathArray;//目标路径名数组
@property(nonatomic,strong)NSMutableArray *fileList;//正在下载的文件model列表
@end
@implementation FileDownLoadManager
static  FileDownLoadManager *sharedFilesDownManage = nil;
static dispatch_once_t onceToken;

/**
 *	@brief	初始化
 *
 *	@return	返回自身对象
 */
-(id)init

{
    self=[super init];
    if (self) {
        if(self.basePath)
        {
            //加载已完成的
            [self loadFinishedfiles];
            [self loadTempfiles];
        }
    }
    return self;
}

/**
 *	@brief	多参数初始化
 *
 *	@param 	basePath 	跟路径
 *	@param 	tagerPaths 	目标路径
 *
 *	@return	返回自身对象
 */
-(id)initWithBasePath:(NSString *)basePath TargetPathArray:(NSArray *)tagerPaths
{
    self.basePath=basePath;
    _targetPathArray=[[NSMutableArray alloc]initWithArray:tagerPaths];
    _fileList=[[NSMutableArray alloc]init];
    _downinglist=[[NSMutableArray alloc]init];
    _finishedlist=[[NSMutableArray alloc]init];
    _fileNameDic=[[NSMutableDictionary alloc]init];
    return [self init];
}

+(FileDownLoadManager *) sharedFilesDownManage{

    dispatch_once(&onceToken, ^{
        sharedFilesDownManage=[[self alloc]init];
    });
    return  sharedFilesDownManage;
}

+(FileDownLoadManager *)sharedFilesDownManageWithBasepath:(NSString *)basepath TargetPathArr:(NSArray *)targetpaths
{
    dispatch_once(&onceToken, ^{
        sharedFilesDownManage=[[self alloc]initWithBasePath:basepath TargetPathArray:targetpaths];
    });
    if (![sharedFilesDownManage.basePath isEqualToString:basepath]) {
          sharedFilesDownManage.basePath=basepath;
        [sharedFilesDownManage loadFinishedfiles];
        [sharedFilesDownManage loadTempfiles];
    }
    sharedFilesDownManage.targetPathArray=[NSMutableArray arrayWithArray:targetpaths];
    return sharedFilesDownManage;
}

//加载下载完的文件
-(void)loadFinishedfiles
{
    NSString *document = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *plistPath = [[document stringByAppendingPathComponent:self.basePath]stringByAppendingPathComponent:@"finishPlist.plist"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:plistPath]) {
        NSMutableArray *finishArr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
        for (NSDictionary *dic in finishArr) {
            FileModel *file = [[FileModel alloc]init];
            file.fileID=[dic objectForKey:@"fileid"];
            file.fileName = [dic objectForKey:@"filename"];
            file.fileType = [file.fileName pathExtension ];
            file.fileSize = [dic objectForKey:@"filesize"];
            file.targetPath = [dic objectForKey:@"filepath"];
            file.time = [dic objectForKey:@"time"];
            file.fileimage = [UIImage imageWithData:[dic objectForKey:@"fileimage"]];
            [_finishedlist addObject:file];
            
        }
        
    }
}

//加载临时文件
-(void)loadTempfiles
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error;
    NSArray *filelist=[fileManager contentsOfDirectoryAtPath:[CommonHelper getTempFolderPathWithBasepath:_basePath] error:&error];
    if(error)
    {
        NSLog(@"%@",[error description]);
    }
    NSMutableArray *filearr = [[NSMutableArray alloc]init];
    for(NSString *file in filelist)
    {
        NSString *filetype = [file  pathExtension];
        if([filetype isEqualToString:@"plist"])
            [filearr addObject:[self getTempfile:[[CommonHelper getTempFolderPathWithBasepath:_basePath] stringByAppendingPathComponent:file]]];
    }
    [_fileList addObjectsFromArray:filearr];
}

/**
 *	@brief  开始下载
 *
 *	@param 	name 	文件名
 *	@param 	targetPath 	目标路径
 */
-(void)downFileUrl:(NSString*) urlStr filename:(NSString*)name filetarget:(NSString*)targetPath fileid:(NSString *)fileid;
{
    self.TargetSubPath=targetPath;
    _fileInfo=[[FileModel alloc]init];
    _fileInfo.fileID=fileid;
    _fileInfo.fileName=name;
    _fileInfo.fileURL=urlStr;
    _fileInfo.time=[CommonHelper dateToString:[NSDate date]];
    _fileInfo.fileType=[name pathExtension];
    //本地若无相应文件夹 创建文件夹
    targetPath=[CommonHelper getTargetPathWithBasepath:_basePath subpath:targetPath];
    //本地储存路径
    _fileInfo.targetPath=targetPath;
    _fileInfo.isDownloading=YES;
    _fileInfo.willDownloading=YES;
    _fileInfo.error=NO;
    _fileInfo.isFirstReceived=YES;
    //临时路径
    _fileInfo.tempPath=[[CommonHelper getTempFolderPathWithBasepath:_basePath]stringByAppendingPathComponent:_fileInfo.fileName];
    //获得缓存文件夹里面的 flist文件
    NSMutableArray *tempAllPlist=[self getTempFiles];
    //判断当前文件是否在下载列表
    BOOL IsExite=NO;
    for (int i=0; i<tempAllPlist.count; i++) {
        FileModel *fModel=[tempAllPlist objectAtIndex:i];
        if ([fModel.fileName isEqualToString:_fileInfo.fileName]) {
            IsExite=YES;
            break;
        }
    }
    //如果当前文件正在下载 弹出提示信息 并return
    if(!IsExite)
    {
        [_fileList addObject:_fileInfo];
        [self saveDownloadFile:_fileInfo];
    }else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"%@已经进入下载队列",_fileInfo.fileName] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    if(!_queue)
    {
        [self newASINetworkQueueWithUrl:_fileInfo];
    }else
    {
        [self addNewRequestWithGuid:_fileInfo];
    }
}
//初始化队列，并向队列加入任务
- (void)newASINetworkQueueWithUrl:(FileModel *)fileInfo
{
    if(_queue==nil)
        _queue = [[ASINetworkQueue alloc]init];
    //设置最大的并发数
    _queue.maxConcurrentOperationCount = 10;
    ASIHTTPRequest *request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fileInfo.fileURL]];
    request.delegate=self;
    //设置文件的保存路径
    [request setDownloadDestinationPath:fileInfo.targetPath];
    //设置文件的临时保存路径
    [request setTemporaryFileDownloadPath:fileInfo.tempPath];
    //设置进度条的代理
    [request setDownloadProgressDelegate:self];
    //设置超时自动连接的次数
    [request setNumberOfTimesToRetryOnTimeout:2];
    //支持断点续传
    [request setAllowResumeForFileDownloads:YES];
    //设置上下文的文件基本信
    [request setUserInfo:[NSDictionary dictionaryWithObject:fileInfo forKey:@"File"]];
    [_queue addOperation:request];
    [self.downinglist addObject:request];
    [_queue setShouldCancelAllRequestsOnFailure:NO];
    //只有从入口进去的才启动下载，只是打开页面不执行
    [_queue go];
}
//向队列中加入任务
- (void)addNewRequestWithGuid:(FileModel *)fileInfo
{
    if(_queue==nil)
        _queue = [[ASINetworkQueue alloc]init];
    
    _queue.maxConcurrentOperationCount = 10;
    ASIHTTPRequest *request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fileInfo.fileURL]];
    request.delegate=self;
    [request setDownloadDestinationPath:[fileInfo targetPath]];
    [request setTemporaryFileDownloadPath:fileInfo.tempPath];
    [request setDownloadProgressDelegate:self];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request setAllowResumeForFileDownloads:YES];
    [request setUserInfo:[NSDictionary dictionaryWithObject:fileInfo forKey:@"File"]];
    [_queue addOperation:request];
    [self.downinglist addObject:request];
    
    
}
//初始化并继续下载
- (void)keepOnNewASINetworkQueueWithGuid:(FileModel*)fileInfo
{
    
    if(_queue==nil)
        _queue = [[ASINetworkQueue alloc]init];
    _queue.maxConcurrentOperationCount =10;
    ASIHTTPRequest *request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:fileInfo.fileURL]];
    request.delegate=self;
    [request setDownloadDestinationPath:[fileInfo targetPath]];
    [request setTemporaryFileDownloadPath:fileInfo.tempPath];
    [request setDownloadProgressDelegate:self];
    [request setNumberOfTimesToRetryOnTimeout:2];
    [request setAllowResumeForFileDownloads:YES];
    [request setUserInfo:[NSDictionary dictionaryWithObject:fileInfo forKey:@"File"]];
    [_queue addOperation:request];
    [self.downinglist addObject:request];
    [_queue go];
    
}

/**
 *	@brief	获得临时文件相关信息
 *
 *	@return	临时文件 model 数组
 */
-(NSMutableArray *)getTempFiles

{
    NSMutableArray *fileArray = [[NSMutableArray alloc]init];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error;
    NSArray *filelist=[fileManager contentsOfDirectoryAtPath:[CommonHelper getTempFolderPathWithBasepath:_basePath] error:&error];
    if(error)
    {
        NSLog(@"%@",[error description]);
        return nil;
    }
    for(NSString *file in filelist)
    {
        NSString *filetype = [file  pathExtension];
        if([filetype isEqualToString:@"plist"])
            [fileArray addObject:[self getTempfile:[[CommonHelper getTempFolderPathWithBasepath:_basePath] stringByAppendingPathComponent:file]]];
    }
    return fileArray;
}
/**
 *	@brief	获取临时文件的相关model信息
 *
 *	@param 	path 	临时文件plist路径
 *
 *	@return	该plist文件转化后的model
 */
-(FileModel *)getTempfile:(NSString *)path

{
    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:path];
    FileModel *file=[[FileModel alloc]init];
    file.fileID=[dic objectForKey:@"fileid"];
    file.fileName = [dic objectForKey:@"filename"];
    file.fileType = [file.fileName pathExtension ];
    file.fileURL = [dic objectForKey:@"fileurl"];
    file.fileSize = [dic objectForKey:@"filesize"];
    file.fileReceivedSize= [dic objectForKey:@"filerecievesize"];
    self.basePath = [dic objectForKey:@"basepath"];
    self.TargetSubPath = [dic objectForKey:@"tarpath"];
    file.targetPath= [[CommonHelper getTargetPathWithBasepath:_basePath subpath:_TargetSubPath] stringByAppendingPathComponent:file.fileName];
    NSString *tempfilePath= [[CommonHelper getTempFolderPathWithBasepath:_basePath] stringByAppendingPathComponent: file.fileName];
    file.tempPath = tempfilePath;
    file.time = [dic objectForKey:@"time"];
    file.fileimage =nil;
    file.isDownloading=NO;
    file.willDownloading = NO;
    file.error = NO;
    NSData *fileData=[[NSFileManager defaultManager ] contentsAtPath:file.tempPath];
    NSInteger receivedDataLength=[fileData length];
    file.fileReceivedSize=[NSString stringWithFormat:@"%ld",receivedDataLength];
    return file;
}
/**
 *	@brief	保存临时下载文件
 *
 *	@param 	fileinfo 	临时文件model
 */
-(void)saveDownloadFile:(FileModel*)fileinfo
{
    NSDictionary *filedic = [NSDictionary dictionaryWithObjectsAndKeys:fileinfo.fileID,@"fileid",fileinfo.fileName,@"filename",fileinfo.fileURL,@"fileurl",fileinfo.time,@"time",_basePath,@"basepath",_TargetSubPath,@"tarpath" ,fileinfo.fileSize,@"filesize",fileinfo.fileReceivedSize,@"filerecievesize",nil,@"fileimage",nil];
    NSString *plistPath = [fileinfo.tempPath stringByAppendingPathExtension:@"plist"];
    if (![filedic writeToFile:plistPath atomically:YES]) {
        NSLog(@"write plist fail");
    }
}
#pragma mark - ASIHTTPRequestDelegate

-(void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    FileModel *fileInfo=[request.userInfo objectForKey:@"File"];
    NSLog(@"%@ =======================>下载请求返回已收到！",fileInfo.fileName);
    NSString *len = [responseHeaders objectForKey:@"Content-Length"];
    NSLog(@"==========================>%@的大小为:%@",fileInfo.fileName,len );
    //这个信息头，首次收到的为总大小，那么后来续传时收到的大小为肯定小于或等于首次的值，则忽略
    if ([fileInfo.fileSize longLongValue]> [len longLongValue])
    {
        return;
    }
    fileInfo.fileSize = [NSString stringWithFormat:@"%lld",[len longLongValue]];
    [_fileNameDic setObject:len forKey:fileInfo.fileName];
    //覆盖之前的 plist文件
    [self saveDownloadFile:fileInfo];

}

-(void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes
{
    FileModel *fileInfo=[request.userInfo objectForKey:@"File"];
    if (fileInfo.isFirstReceived) {
        fileInfo.isFirstReceived=NO;
        fileInfo.fileReceivedSize =[NSString stringWithFormat:@"%lld",bytes];
    }else
    {
        fileInfo.fileReceivedSize=[NSString stringWithFormat:@"%lld",[fileInfo.fileReceivedSize longLongValue]+bytes];
    }
}


-(void)requestStarted:(ASIHTTPRequest *)request
{
    FileModel *fileInfo=(FileModel *)[request.userInfo objectForKey:@"File"];
    NSLog(@"%@ ============> 开始下载了!",fileInfo.fileName);
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error=[request error];
    NSLog(@"ASIHttpRequest出错了!%@",error);
    //出错了 如果是等待超时, 则继续下载
    if (error.code==4) {
        return;
    }
    if ([request isExecuting]) {
        [request cancel];
    }
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    FileModel *fileInfo=(FileModel *)[request.userInfo objectForKey:@"File"];
    [self.finishedlist addObject:fileInfo];
    NSString *configPath=[fileInfo.tempPath  stringByAppendingPathExtension:@"plist"];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error;
    if([fileManager fileExistsAtPath:configPath])//如果存在临时文件的配置文件
    {
        [fileManager removeItemAtPath:configPath error:&error];
        if(error)
        {
          NSLog(@"%@",[error description]);
            
        }
    }
    [_fileList removeObject:fileInfo];
    [_downinglist removeObject:request];
    [self saveFinishedFile];
    if([self.downloadDelegate respondsToSelector:@selector(finishedDownload:)])
    {
        [self.downloadDelegate finishedDownload:request];
    }
}

/**
 *	@brief	保存已下载的文件信息
 */
-(void)saveFinishedFile

{
    
    if (self.finishedlist==nil) {
        return;
    }
    NSMutableArray *finishedinfo = [[NSMutableArray alloc]init];
    for (FileModel *fileinfo in self.finishedlist) {
        
        NSDictionary *filedic = [NSDictionary dictionaryWithObjectsAndKeys:fileinfo.fileID,@"fileid",fileinfo.fileName,@"filename",fileinfo.time,@"time",fileinfo.fileSize,@"filesize",fileinfo.targetPath,@"filepath",nil,@"fileimage", nil];
        [finishedinfo addObject:filedic];
    }
    NSString *document = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *plistPath = [[document stringByAppendingPathComponent:self.basePath]stringByAppendingPathComponent:@"finishPlist.plist"];
    if (![finishedinfo writeToFile:plistPath atomically:YES]) {
        NSLog(@"write plist fail");
    }
}

@end
