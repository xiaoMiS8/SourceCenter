//
//  FileInfo.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/16.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "FileInfo.h"

@implementation FileInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.AllCount = [dict[kAllCount] intValue];
        self.ElseCount = [dict[kElseCount] intValue];
        self.PicCount = [dict[kPicCount] intValue];
        self.VideoCount = [dict[kVideoCount] intValue];
        self.rowscount = [dict[krowscount] intValue];
        self.FileID = [dict[kFileID] longValue];
        self.FileTitle = dict[kFileTitle];
        self.Ext = dict[kExt];
        self.FileType = [dict[kFileType] intValue];
        self.FileSize = [dict[kFileSize] longValue];
        self.UploadTime = dict[kUploadTime];
        self.AllowDownload = [dict[kAllowDownload] boolValue];
        self.FileURL = dict[kFileURL];
    }
    return self;
}

@end
