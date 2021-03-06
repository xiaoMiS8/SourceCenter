//
//  DetailDataCell.m
//  CourseCenter
//
//  Created by 2345 on 15/7/19.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "DetailDataCell.h"
#import "CommonHelper.h"
#import "FileDownLoadManager.h"
#import "DetailData.h"
#import "Reachability.h"
#import "MoocFileInfo.h"
@implementation DetailDataCell

- (void)awakeFromNib {
    // Initialization code
    [ _btn initWithbackColor:[UIColor lightGrayColor]
               progressColor:[UIColor greenColor]
                   lineWidth:8];
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    _btn.delegate = self;
    _btn.selected = YES;
    _isFinishL.layer.masksToBounds=YES;
    _isFinishL.layer.cornerRadius=5;
}
- (void)btnAction
{
    if (_IsAllowStudy==1) {
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
    }else
    {
        switch (_IsAllowStudy) {
            case 0:{
                [Tool showAlertView:@"提示" withMessage:@"请先学习前面的章节" withTarget:self withCancel:@"确定" other:nil];
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
}
- (void)downloadFileName
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != kNotReachable)
    {
        [[FileDownLoadManager sharedFilesDownManage] downFileUrl:_fileModel.fileURL filename:_fileModel.fileName filetarget:TARGER fileid:_fileModel.fileID chapterID:_fileModel.ChapterID fileType:_fileModel.fileType];
        [self.parentVC changeFileState];
    }else{
        [Tool showAlertView:@"提示" withMessage:@"网络不通,请检查网路" withTarget:nil withCancel:@"确定" other:nil];
    }
}
-(void)setFileModel:(FileModel *)fileModel
{
    if (_fileModel!=fileModel) {
        _fileModel=fileModel;
    }
    if ([_isFinish isEqualToString:@"YES"]) {
        _size.text=@"已下载本地";
    }else
    {
        _size.text=[NSString stringWithFormat:@"%@/%@",[CommonHelper getFileSizeString:_fileModel.fileReceivedSize],[CommonHelper getFileSizeString:_fileModel.fileSize]];
    }
    _title.text=_fileModel.fileName;
    if ([_fileModel.fileType integerValue]==1) {
        _image.image=[UIImage imageNamed:@"icon_video2"];
    }else if([_fileModel.fileType integerValue]==2)
    {
        _image.image=[UIImage imageNamed:@"word"];
    }else if([_fileModel.fileType integerValue]==3)
    {
        _image.image=[UIImage imageNamed:@"excel"];
    }else if([_fileModel.fileType integerValue]==4)
    {
        _image.image=[UIImage imageNamed:@"ppt"];
    }else if([_fileModel.fileType integerValue]==5)
    {
        _image.image=[UIImage imageNamed:@"pdf"];
    }else if([_fileModel.fileType integerValue]==6)
    {
        _image.image=[UIImage imageNamed:@"icon_photo"];
    }else if([_fileModel.fileType integerValue]==7)
    {
        _image.image=[UIImage imageNamed:@"other"];
    }else if([_fileModel.fileType integerValue]==8)
    {
        _image.image=[UIImage imageNamed:@"icon_document1"];
    }else if([_fileModel.fileType integerValue]==9)
    {
        _image.image=[UIImage imageNamed:@""];
    }
    if (_fileModel.IsReadFinish) {
        _isFinishL.hidden=YES;
    }else
    {
        _isFinishL.hidden=NO;
    }
}
- (void)downloadFile
{
    if(_fileModel==nil)
        return;
    [[FileDownLoadManager sharedFilesDownManage]keepOnNewASINetworkQueueWithGuid:_fileModel];
    [self.parentVC changeFileState];
}
- (void)stopDownloadFile
{
    [_request cancel];
    [(DetailData*)self.parentVC removeASIRequst:_request];
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
    [_btn setProgress:[_fileModel.fileReceivedSize floatValue]/[_fileModel.fileSize floatValue]];
    
}
- (void)updateProgressViewWithProgress:(float)progress
{
    float cur= [_fileModel.fileSize floatValue]*progress;
    _size.text=[NSString stringWithFormat:@"%@/%@",[CommonHelper getFileSizeString:[NSString stringWithFormat:@"%f",cur]],[CommonHelper getFileSizeString:_fileModel.fileSize]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
