//
//  NTTextViewCell.m
//  CourseCenter
//
//  Created by 任晓健 on 15/8/6.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NTTextViewCell.h"

@implementation NTTextViewCell

- (void)awakeFromNib {
   
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGRect bounds = textView.bounds;
        // 计算 text view 的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    bounds.size = newSize;
    textView.bounds = bounds;
        // 让 table view 重新计算高度
    UITableView *tableView = [self tableView];
    [tableView beginUpdates];
    [tableView endUpdates];
}
- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
