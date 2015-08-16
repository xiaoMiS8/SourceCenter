//
//  TextViewCell.m
//  TextViewTest
//
//  Created by 任晓健 on 15/8/9.
//  Copyright (c) 2015年 任晓健. All rights reserved.
//

#import "TextViewCell.h"

@implementation TextViewCell

- (void)awakeFromNib {
    [_textView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
