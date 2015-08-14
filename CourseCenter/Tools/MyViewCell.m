//
//  MyViewCell.m
//  ZHResume
//
//  Created by muzhenhua on 15/8/12.
//  Copyright (c) 2015年 muzhenhua. All rights reserved.
//

#import "MyViewCell.h"
#import "CommonHelper.h"
#import "FileDownLoadManager.h"
#import "ViewController.h"
#import "Reachability.h"
@implementation MyViewCell

- (void)awakeFromNib {
    // Initialization code
   [ _btn initWithbackColor:[UIColor lightGrayColor]
            progressColor:[UIColor greenColor]
            lineWidth:8];
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    _btn.delegate = self;
    _btn.selected = YES;
    self.contentView.backgroundColor=[UIColor yellowColor];
}
- (void)btnAction
{
    if (_btn.selected) {
        if (_isFirst) {
           [self downloadFileName];
        }else
        {
          [self downloadFile];
        }
        
    }else{
        [self stopDownloadFile];
    }
    _btn.selected=!_btn.selected;
}
- (void)downloadFileName
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable)
    {
        [[FileDownLoadManager sharedFilesDownManage] downFileUrl:_fileModel.fileURL filename:_fileModel.fileName filetarget:TARGER fileid:_fileModel.fileID];
        [self.parentVC loadData];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]
        initWithTitle:@"提示" message:@"网络不通,请检查网路"
        delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
    }
}
-(void)setFileModel:(FileModel *)fileModel
{
    if (_fileModel!=fileModel) {
        _fileModel=fileModel;
    }
    if ([_isFinish isEqualToString:@"YES"]) {
        _label1.text=_fileModel.fileName;
        _label2.text=@"已下载本地";
    }else
    {
        _label1.text=_fileModel.fileName;
        _label2.text=[NSString stringWithFormat:@"%@/%@",[CommonHelper getFileSizeString:_fileModel.fileReceivedSize],[CommonHelper getFileSizeString:_fileModel.fileSize]];
    }
}
- (void)downloadFile
{
    if(_fileModel==nil)
        return;
    [[FileDownLoadManager sharedFilesDownManage]keepOnNewASINetworkQueueWithGuid:_fileModel];
    [self.parentVC loadData];
}
- (void)stopDownloadFile
{
    [_request cancel];
    [(ViewController*)self.parentVC removeASIRequst:_request];
}

- (void)setRequest:(ASIHTTPRequest *)request
{
    if (request == nil) {
        _request = nil;
        _btn.selected = YES;
        _btn.progress = 0;
        return;
    }else{
        _request = nil;
        _btn.progress = 0;
        _request = request;
        [_request setDownloadProgressDelegate:_btn];
        [_request setShowAccurateProgress:YES];
        _btn.selected = NO;
    }
}
-(void)setPercent
{
    float mm=[_fileModel.fileReceivedSize floatValue]/[_fileModel.fileSize floatValue];
    [_btn setProgress:[_fileModel.fileReceivedSize floatValue]/[_fileModel.fileSize floatValue]];
    
}
- (void)updateProgressViewWithProgress:(float)progress
{
    float cur= [_fileModel.fileSize floatValue]*progress;
    _label2.text=[NSString stringWithFormat:@"%@/%@",[CommonHelper getFileSizeString:[NSString stringWithFormat:@"%f",cur]],[CommonHelper getFileSizeString:_fileModel.fileSize]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
