//
//  NewNotimgCell.h
//  CourseCenter
//
//  Created by jian on 15/7/19.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewNotimgCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *oneImage;
@property (weak, nonatomic) IBOutlet UIImageView *twoImage;
@property (weak, nonatomic) IBOutlet UIImageView *threeImage;

@property(nonatomic, strong) NSArray *imgs;

@end
