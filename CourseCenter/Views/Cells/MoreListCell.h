//
//  MoreListCell.h
//  CourseCenter
//
//  Created by 2345 on 15/7/10.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
@interface MoreListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *headImag;
@property (weak, nonatomic) IBOutlet UILabel *headName;
@property (weak, nonatomic) IBOutlet UILabel *messageNum;
@property (strong,nonatomic)NSIndexPath *indexPath;
@property (strong,nonatomic)UserInfo *userInfo;
@end
