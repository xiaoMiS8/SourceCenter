//
//  AttachmentInfo.h
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AttachmentInfo : NSObject

    ///文件后缀图片1视频2
@property(nonatomic, assign) int FileExtType;
    ///缩略图
@property(nonatomic, strong) NSString *Thumbnail;
    ///主键
@property(nonatomic, assign) long AttachmentID;
    ///存储服务器ID
@property(nonatomic, assign) long ServerID;
    ///文件存储名称
@property(nonatomic, strong) NSString *FileName;
    ///文件原始名称
@property(nonatomic, strong) NSString *Title;
    ///文件大小字节为单位
@property(nonatomic, assign) long FileSize;
    ///文件来源
@property(nonatomic, strong) NSString *Source;
    ///来源表的主键
@property(nonatomic, assign) long SourceID;
    ///文件上传时间
@property(nonatomic, strong) NSString *Updatetime;
    ///下载地址
@property(nonatomic, strong) NSString *DownURL;
    ///预览地址
@property(nonatomic, strong) NSString *ViewURL;

@end
