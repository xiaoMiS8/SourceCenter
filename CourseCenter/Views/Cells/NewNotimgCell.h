//
//  NewNotimgCell.h
//  CourseCenter
//
//  Created by jian on 15/7/19.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DeleteBlock)(UIButton *btn);

@interface NewNotimgCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *oneImage;
@property (weak, nonatomic) IBOutlet UIImageView *twoImage;
@property (weak, nonatomic) IBOutlet UIImageView *threeImage;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;

@property(nonatomic, copy) DeleteBlock deleteBlock;

@property(nonatomic, strong) NSArray *imgs;

@end
