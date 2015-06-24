//
//  NotiDetailCell.h
//  CourseCenter
//
//  Created by renxiaojian on 15/5/29.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NotiDetailCellDelegate;

@interface NotiDetailCell : UITableViewCell

@property(nonatomic, weak) id<NotiDetailCellDelegate> deleagate;

@end

@protocol NotiDetailCellDelegate <NSObject>

- (void)textviewHeightChanged;

@end