//
//  imgsCell.m
//  CourseCenter
//
//  Created by 任晓健 on 15/8/9.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "imgsCell.h"

@implementation imgsCell

- (void)awakeFromNib {
   
}

- (void)setImgs:(NSArray *)imgs {
    _imgs = imgs;
    if (!imgs || imgs.count == 0) {
        for (NSLayoutConstraint *constraint in self.imgsView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 0;
            }
        }
    } else {
        
        int row = (int)imgs.count/3;
        if (imgs.count % 3 > 0) {
            row = row + 1;
        }
        
        for (NSLayoutConstraint *constraint in self.imgsView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 100 *row;
            }
        }
        CGFloat offset = 10;
        CGFloat width = (self.imgsView.bounds.size.width -14 - 10 * 4)/3;
        for (int i=0; i<imgs.count; i++) {
            int row = i / 3;
            int lon = i % 3;
            UIImageView *img = [[UIImageView alloc] init];
            img.userInteractionEnabled = YES;
            img.image = imgs[i];
            img.frame = CGRectMake(offset + lon *(offset + width),offset + row *(offset + width), width, width);
            img.backgroundColor = [UIColor purpleColor];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            [btn setTitle:@"x" forState:UIControlStateNormal];
            btn.layer.cornerRadius = 8;
            btn.layer.masksToBounds = YES;
            btn.backgroundColor = [UIColor grayColor];
            btn.frame = CGRectMake(CGRectGetWidth(img.frame) - 12, -6, 16, 16);
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            [img addSubview:btn];
            [self.imgsView addSubview:img];
        }
    }
}

- (void)btnAction:(UIButton *)btn {
    self.DeleteBlock(btn.tag);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
