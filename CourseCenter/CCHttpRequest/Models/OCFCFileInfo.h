//
//  OCFCFileInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFCFileID           @"FCFileID"
#define kFCID               @"FCID"
#define kFileID             @"FileID"
#define kFileTitle          @"FileTitle"
#define kDownUrl            @"DownUrl"
#define kFileType           @"FileType"
#define kFileSize           @"FileSize"

@interface OCFCFileInfo : NSObject

    ///翻转课堂文件ID
@property(nonatomic, assign) long FCFileID;
    ///翻转课堂ID
@property(nonatomic, assign) long FCID;
    ///文件ID
@property(nonatomic, assign) long FileID;
    ///文件名称
@property(nonatomic, strong) NSString *FileTitle;
    ///下载地址
@property(nonatomic, strong) NSString *DownUrl;
    ///文件类型
@property(nonatomic, assign) int FileType;
    ///文件大小字节
@property(nonatomic, assign) long FileSize;

- (id)initWithDict:(NSDictionary *)dict;

@end
