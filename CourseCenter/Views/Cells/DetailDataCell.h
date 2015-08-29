//
//  DetailDataCell.h
//  CourseCenter
//
//  Created by 2345 on 15/7/19.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileInfo.h"
#import "CircularProgressButton.h"
#import "FileModel.h"
#import "ASIHTTPRequest.h"
@interface DetailDataCell : UITableViewCell<CircularProgressButtonDelegate>
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *size;
@property (weak, nonatomic) IBOutlet CircularProgressButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *isFinishL;
@property(nonatomic,strong)FileInfo *fileInfo;
@property (nonatomic,strong)FileModel *fileModel;
@property (nonatomic, weak) ASIHTTPRequest *request;
@property(nonatomic,weak) id parentVC;
@property(nonatomic,strong)NSString *isFinish;
@property(nonatomic,assign)BOOL isFirst;
@property(nonatomic,assign)int  IsAllowStudy;
-(void)setPercent;
@end
