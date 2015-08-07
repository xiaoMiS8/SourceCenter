//
//  NTCell2.m
//  CourseCenter
//
//  Created by 任晓健 on 15/8/7.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NTCell2.h"

@implementation NTCell2

- (void)awakeFromNib {
    [self initTextView];
}

- (void)initTextView {
    
    self.textView.isScrollable = NO;
    self.textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
    self.textView.minNumberOfLines = 1;
    self.textView.maxNumberOfLines = 6;
        // you can also set the maximum height in points with maxHeight
        // textView.maxHeight = 200.0f;
    self.textView.returnKeyType = UIReturnKeyGo; //just as an example
    self.textView.font = [UIFont systemFontOfSize:15.0f];
    self.textView.delegate = self;
    self.textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.placeholder = @"Type to see the textView grow!";
    
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    self.textViewDidChangeBlock(height);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
