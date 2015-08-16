//
//  MoocFileInfo.h
//  
//
//  Created by jian on 15/6/23.
//
//

#import <Foundation/Foundation.h>

#define kMoocFileID                 @"MoocFileID"
#define kOCID                       @"OCID"
#define kFileID                     @"FileID"
#define kChapterID                  @"ChapterID"
#define kTimelimit                  @"Timelimit"
#define kIsMust                     @"IsMust"
#define kFileTitle                  @"FileTitle"
#define kDownUrl                    @"DownUrl"
#define kViewUrl                    @"ViewUrl"
#define kFileViewURL                @"FileViewURL"
#define kIsTransfer                 @"IsTransfer"
#define kTimeLength                 @"TimeLength"
#define kFileType                   @"FileType"
#define kExt                        @"Ext"
#define kUploadTime                 @"UploadTime"
#define kFinishRate                 @"FinishRate"
#define kIsReadFinish               @"IsReadFinish"
#define kVideoNeedRate              @"VideoNeedRate"
#define kIsAllowStudy               @"IsAllowStudy"
#define kSeconds                    @"Seconds"

@interface MoocFileInfo : NSObject

    //ID
@property(nonatomic, assign) long       MoocFileID;
    //在线课程ID
@property(nonatomic, assign) long       OCID;
    //父章节ID
@property (nonatomic,assign) long        ParentID;
    //章节ID
@property(nonatomic, assign) long       ChapterID;
    //文件ID
@property(nonatomic, assign) long       FileID;
    //学习时长
@property(nonatomic, assign) long       Timelimit;
    //是否必须
@property(nonatomic, assign) BOOL       IsMust;
    //文件名
@property(nonatomic, strong) NSString   *FileTitle;
    //下载地址
@property(nonatomic, strong) NSString   *DownUrl;
    //文件地址
@property(nonatomic, strong) NSString   *ViewUrl;
    //预览页面地址
@property(nonatomic, strong) NSString   *FileViewURL;
    //文件是否转换成功 0:未转换 1:成功 2:失败
@property(nonatomic, assign) BOOL       IsTransfer;
    //视频文件时长
@property(nonatomic, assign) int        TimeLength;
    //文件类型
@property(nonatomic, assign) int        FileType;
    //后缀名
@property(nonatomic, strong) NSString   *Ext;
    //上传时间
@property(nonatomic, strong) NSString   *UploadTime;
    //资源的完成率
@property(nonatomic, assign) float      FinishRate;
    //是否学习完
@property(nonatomic, assign) BOOL       IsReadFinish;
    //学习百分比多少才算完成
@property(nonatomic, assign) float      VideoNeedRate;
    //是否允许学习
@property(nonatomic, assign) int       IsAllowStudy;
    // 0
@property(nonatomic, assign) int        Seconds;

- (id)initWithDict:(NSDictionary *)dict;

@end

