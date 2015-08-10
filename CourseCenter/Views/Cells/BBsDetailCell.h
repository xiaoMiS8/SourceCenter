//
//  BBsDetailCell.h
//  CourseCenter
//
//  Created by jian on 15/8/3.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TopicInfo.h"

@interface BBsDetailCell : UITableViewCell

@property(nonatomic, strong) TopicInfo *topic;
@property(nonatomic, copy) void (^agreeBlock)(void);

@end
