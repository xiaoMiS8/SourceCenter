//
//  NotiDetailCell.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/29.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NotiDetailCell.h"

@interface NotiDetailCell ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation NotiDetailCell

- (void)awakeFromNib {
    self.textView.layer.borderColor = [UIColor blackColor].CGColor;
    self.textView.layer.cornerRadius = 3;
    self.textView.layer.borderWidth = 0.5;
    self.textView.delegate = self;
}

    //得到字符串的size
- (CGSize)getSizeWithString:(NSString *)string
                       font:(UIFont *)font size:(CGSize)size {
    CGSize stringSize = [string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName: font} context:nil].size;
    return stringSize;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    CGSize size = [self getSizeWithString:textView.text font:textView.font size:CGSizeMake(200, 10000)];
    for (NSLayoutConstraint *constraint in self.textView.constraints) {
        if (constraint.firstItem == self.textView && constraint.firstAttribute == NSLayoutAttributeHeight) {
            constraint.constant = size.height + 10;
        }
    }
    [self.contentView layoutIfNeeded];
    [self.contentView updateConstraintsIfNeeded];
    if ([self.deleagate respondsToSelector:@selector(textviewHeightChanged)]) {
        [self.deleagate textviewHeightChanged];
    }
    
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
