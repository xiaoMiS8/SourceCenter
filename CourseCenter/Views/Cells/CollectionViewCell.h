//
//  CollectionViewCell.h
//  CourseCenter
//
//  Created by 2345 on 15/8/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (strong,nonatomic) UserInfo *info;
@end
