//
//  FileDownLoadManager.h
//  BKResume
//
//  Created by muzhenhua on 15/8/10.
//  Copyright (c) 2015年 muzhenhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "FileModel.h"

@protocol DownloadDelegate <NSObject>
@optional
-(void)startDownload:(ASIHTTPRequest *)request;
-(void)updateCellProgress:(ASIHTTPRequest *)request;
-(void)finishedDownload:(ASIHTTPRequest *)request;
@end

@interface FileDownLoadManager : NSObject<ASIHTTPRequestDelegate,ASIProgressDelegate>

//已下载完成的文件列表（文件对象）
@property(nonatomic,retain)NSMutableArray *finishedlist;
//正在下载的文件列表(ASIHttpRequest对象)
@property(nonatomic,retain)NSMutableArray *downinglist;
//下载队列
@property (nonatomic, strong) ASINetworkQueue *queue;
//下载列表delegate
@property(nonatomic,retain)id<DownloadDelegate> downloadDelegate;
//用userinfo存fileModel，不知道为啥 有时候文件大小会丢失，这里新加一个字典，保存文件大小
@property(nonatomic,retain) NSMutableDictionary *fileNameDic;


+(FileDownLoadManager *) sharedFilesDownManage;
+(FileDownLoadManager *) sharedFilesDownManageWithBasepath:(NSString *)basepath TargetPathArr:(NSArray *)targetpaths;
-(void)downFileUrl:(NSString*) urlStr filename:(NSString*)name filetarget:(NSString*)targetPath fileid:(NSString *)fileid;
-(NSMutableArray *)getTempFiles;
- (void)keepOnNewASINetworkQueueWithGuid:(FileModel*)fileInfo;
-(void)saveFinishedFile;
@end
