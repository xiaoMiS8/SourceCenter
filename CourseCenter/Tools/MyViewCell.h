//
//  MyViewCell.h
//  ZHResume
//
//  Created by muzhenhua on 15/8/12.
//  Copyright (c) 2015年 muzhenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularProgressButton.h"
#import "FileModel.h"
#import "ASIHTTPRequest.h"

@interface MyViewCell : UITableViewCell<CircularProgressButtonDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet CircularProgressButton *btn;
@property (nonatomic,strong)FileModel *fileModel;
@property (nonatomic, weak) ASIHTTPRequest *request;
@property(nonatomic,weak) id parentVC;
@property(nonatomic,strong)NSString *isFinish;
@property(nonatomic,assign)BOOL isFirst;
-(void)setPercent;
@end
