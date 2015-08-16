//
//  FileModel.h
//  BKResume
//
//  Created by muzhenhua on 15/8/10.
//  Copyright (c) 2015年 muzhenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject

@property(nonatomic,strong)NSString *fileID;
@property(nonatomic,strong)NSString *fileName;
@property(nonatomic,strong)NSString *fileSize;
@property(nonatomic,strong)NSString *fileType;
//是否是第一次接受数据，如果是则不累加第一次返回的数据长度，之后变累加
@property(nonatomic)BOOL isFirstReceived;
//接受的数据
@property(nonatomic,strong)NSString *fileReceivedSize;
@property(nonatomic,strong)NSMutableData *fileReceivedData;
@property(nonatomic,strong)NSString *fileURL;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *targetPath;
@property(nonatomic,strong)NSString *tempPath;
@property(nonatomic)BOOL isDownloading;//是否正在下载
@property(nonatomic)BOOL  willDownloading;
@property(nonatomic)BOOL error;
@property(nonatomic)BOOL isP2P;//是否是p2p下载
@property BOOL post;
@property int PostPointer;
@property(nonatomic,strong)NSString *postUrl;
@property (nonatomic,strong)NSString *fileUploadSize;
@property(nonatomic,strong)NSString *usrname;
@property(nonatomic,strong)NSString *MD5;
@property(nonatomic,strong)UIImage *fileimage;

@end
