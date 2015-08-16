//
//  MyData.h
//  CourseCenter
//
//  Created by 2345 on 15/7/18.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"
#import "FileDownLoadManager.h"
@interface MyData : BaseViewController<DownloadDelegate>
@property (nonatomic, assign) int FileType;
-(void)changeFileState;
-(void)removeASIRequst:( ASIHTTPRequest*)request;
@end
