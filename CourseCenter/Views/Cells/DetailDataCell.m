//
//  DetailDataCell.m
//  CourseCenter
//
//  Created by 2345 on 15/7/19.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "DetailDataCell.h"

@implementation DetailDataCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setFileInfo:(FileInfo *)fileInfo
{
    if (_fileInfo==nil) {
        _fileInfo=fileInfo;
    }
    _title.text=_fileInfo.FileTitle;
    if (_fileInfo.FileType==1) {
        _image.image=[UIImage imageNamed:@"icon_video2"];
    }else if(_fileInfo.FileType==2)
    {
        _image.image=[UIImage imageNamed:@"word"];
    }else if(_fileInfo.FileType==3)
    {
        _image.image=[UIImage imageNamed:@"excel"];
    }else if(_fileInfo.FileType==4)
    {
        _image.image=[UIImage imageNamed:@"ppt"];
    }else if(_fileInfo.FileType==5)
    {
        _image.image=[UIImage imageNamed:@"pdf"];
    }else if(_fileInfo.FileType==6)
    {
        _image.image=[UIImage imageNamed:@"icon_photo"];
    }else if(_fileInfo.FileType==7)
    {
        _image.image=[UIImage imageNamed:@"other"];
    }else if(_fileInfo.FileType==8)
    {
        _image.image=[UIImage imageNamed:@"icon_document1"];
    }else if(_fileInfo.FileType==9)
    {
        _image.image=[UIImage imageNamed:@"other"];
    }
    _size.text=[NSString stringWithFormat:@"大小:%ldM",_fileInfo.FileSize/1024/1024];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
