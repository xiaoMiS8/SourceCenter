//
//  OCFCFileInfo.m
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "OCFCFileInfo.h"

@implementation OCFCFileInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.FCFileID = [dict[kFCFileID] longValue];
        self.FCID = [dict[kFCID] longValue];
        self.FileID = [dict[kFileID] longValue];
        self.FileTitle = dict[kFileTitle];
        self.DownUrl = dict[kDownUrl];
        self.FileType = [dict[kFileType] intValue];
        self.FileSize = [dict[kFileSize] intValue];
    }
    return self;
}

@end
