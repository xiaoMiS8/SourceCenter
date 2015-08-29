//
//  TutorialViewController.h
//  CourseCenter
//
//  Created by jian on 15/7/25.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "CourseBaseViewController.h"
#import "FileDownLoadManager.h"
@interface TutorialViewController : CourseBaseViewController<DownloadDelegate,UIAlertViewDelegate,UIDocumentInteractionControllerDelegate>
@property(nonatomic,assign)long OCID;
@property(nonatomic, assign) int FileType;
-(void)changeFileState;
-(void)removeASIRequst:( ASIHTTPRequest*)request;
@end
