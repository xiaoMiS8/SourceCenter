//
//  MoocFileInfo.m
//  
//
//  Created by jian on 15/6/23.
//
//

#import "MoocFileInfo.h"

@implementation MoocFileInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.MoocFileID = [[dict objectForKey:kMoocFileID] longValue];
        self.OCID = [[dict objectForKey:kOCID] longValue];
        self.ChapterID = [[dict objectForKey:kChapterID] longValue];
        self.FileID = [[dict objectForKey:kFileID] longValue];
        self.Timelimit = [[dict objectForKey:kTimelimit] longValue];
        self.IsMust = [[dict objectForKey:kIsMust] boolValue];
        self.FileTitle = [dict objectForKey:kFileTitle];
        self.DownUrl = [dict objectForKey:kDownUrl];
        self.ViewUrl = [dict objectForKey:kViewUrl];
        self.FileViewURL = [dict objectForKey:kFileViewURL];
        self.IsTransfer = [[dict objectForKey:kIsTransfer] boolValue];
        self.TimeLength = [[dict objectForKey:kTimeLength] intValue];
        self.FileType = [[dict objectForKey:kFileType] intValue];
        self.Ext = [dict objectForKey:kExt];
        self.UploadTime = [dict objectForKey:kUploadTime];
        self.FinishRate = [[dict objectForKey:kFinishRate] floatValue];
        self.IsReadFinish = [[dict objectForKey:kIsReadFinish] boolValue];
        self.VideoNeedRate = [[dict objectForKey:kVideoNeedRate] floatValue];
        self.IsAllowStudy = [[dict objectForKey:kIsAllowStudy] boolValue];
        self.Seconds = [[dict objectForKey:kSeconds] intValue];
    }
    return self;
}

@end
