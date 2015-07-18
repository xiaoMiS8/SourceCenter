//
//  FileInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/16.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAllCount               @"AllCount"
#define kElseCount              @"ElseCount"
#define kPicCount               @"PicCount"
#define kVideoCount             @"VideoCount"
#define krowscount              @"rowscount"
#define kFileID                 @"FileID"
#define kFileTitle              @"FileTitle"
#define kExt                    @"Ext"
#define kFileType               @"FileType"
#define kFileSize               @"FileSize"
#define kUploadTime             @"UploadTime"
#define kAllowDownload          @"AllowDownload"
#define kFileURL                @"FileURL"

@interface FileInfo : NSObject

    //全部资料
@property(nonatomic, assign) int AllCount;
    //文稿资料
@property(nonatomic, assign) int ElseCount;
    // 图片资料
@property(nonatomic, assign) int PicCount;
    //视频资料
@property(nonatomic, assign) int VideoCount;
    //列表总数
@property(nonatomic, assign) int rowscount;
    //文件ID
@property(nonatomic, assign) long FileID;
    //文件名
@property(nonatomic, strong) NSString *FileTitle;
    //后缀名
@property(nonatomic, strong) NSString *Ext;
    //文件类型
@property(nonatomic, assign) int FileType;
    //文件大小字节
@property(nonatomic, assign) long FileSize;
    //上传时间
@property(nonatomic, strong) NSString *UploadTime;
    //是否允许下载
@property(nonatomic, assign) BOOL AllowDownload;
    //文件地址
@property(nonatomic, strong) NSString *FileURL;

- (id)initWithDict:(NSDictionary *)dict;

@end
