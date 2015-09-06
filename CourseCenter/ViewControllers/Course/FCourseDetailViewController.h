//
//  FCourseDetailViewController.h
//  CourseCenter
//
//  Created by muzhenhua on 15/8/3.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "CourseBaseViewController.h"
#import "FileDownLoadManager.h"
@interface FCourseDetailViewController : CourseBaseViewController<DownloadDelegate>
@property (nonatomic,assign)long OCID;
@property (nonatomic,assign)long FCID;
-(void)changeFileState;
-(void)removeASIRequst:( ASIHTTPRequest*)request;
@end
