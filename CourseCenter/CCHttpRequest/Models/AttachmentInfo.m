//
//  AttachmentInfo.m
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "AttachmentInfo.h"

@implementation AttachmentInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.FileExtType = [dict[kFileExtType] intValue];
        self.Thumbnail = dict[kThumbnail];
        self.AttachmentID = [dict[kAttachmentID] longValue];
        self.ServerID = [dict[kServerID] longValue];
        self.FileName = dict[kFileName];
        self.Title = dict[kTitle];
        self.FileSize = [dict[kFileSize] longValue];
        self.Source = dict[kSource];
        self.SourceID = [dict[kSourceID] longValue];
        self.Updatetime = dict[kUpdateTime];
        self.DownURL = dict[kDownURL];
        self.ViewURL = dict[kViewURL];
    }
    return self;
}

@end

