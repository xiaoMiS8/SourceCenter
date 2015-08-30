//
//  CourseDataDetailViewController.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/30.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"
#import "FileDownLoadManager.h"
@interface DetailData : BaseViewController<DownloadDelegate,UIDocumentInteractionControllerDelegate,UIAlertViewDelegate>
@property (nonatomic, assign) long OCID;
@property (nonatomic, assign) int FileType;
-(void)changeFileState;
-(void)removeASIRequst:( ASIHTTPRequest*)request;
@end
