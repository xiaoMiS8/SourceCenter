//
//  imgsCell.h
//  CourseCenter
//
//  Created by 任晓健 on 15/8/9.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imgsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *imgsView;
@property(nonatomic, strong) NSArray *imgs;

@property(nonatomic, copy) void(^DeleteBlock)(NSInteger index);

@end
