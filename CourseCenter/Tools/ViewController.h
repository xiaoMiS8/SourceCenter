//
//  ViewController.h
//  ZHResume
//
//  Created by muzhenhua on 15/8/12.
//  Copyright (c) 2015年 muzhenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileDownLoadManager.h"
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,DownloadDelegate>
-(void)loadData;
-(void)removeASIRequst:( ASIHTTPRequest*)request;
@end

