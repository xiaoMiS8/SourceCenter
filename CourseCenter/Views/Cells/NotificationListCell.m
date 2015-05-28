//
//  NotificationListCell.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NotificationListCell.h"

#define margin              8.0
#define margin_left         10
#define margin_up           2
#define margin_bom          10

@interface NotificationListCell ()

@property(nonatomic, strong) UIImageView *picImg;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *dateLabel;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *messageLabel;

@end

@implementation NotificationListCell

- (void)awakeFromNib {
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

    //得到字符串的size
- (CGSize)getSizeWithString:(NSString *)string
                       font:(UIFont *)font {
    CGSize size = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName: font} context:nil].size;
    return size;
}

- (void)initView {
    self.picImg = [[UIImageView alloc] initWithFrame:CGRectMake(margin_left, margin_left, 50, 50)];
    self.picImg.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.picImg];
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = Font_16;
    [self.contentView addSubview:self.nameLabel];
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.font = Font_16;
    [self.contentView addSubview:self.dateLabel];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = Font_16;
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.font = Font_14;
    self.messageLabel.numberOfLines = 0;
    [self.contentView addSubview:self.messageLabel];
   
}

- (void)setNotification:(NotificationInfo *)notification {
    _notification = notification;
    CGSize nameSize = [self getSizeWithString:notification.name font:self.nameLabel.font];
    CGRect nameRect = (CGRect){{CGRectGetMaxX(self.picImg.frame) + margin, CGRectGetMinY(self.picImg.frame) + 4}, nameSize};
    self.nameLabel.frame = nameRect;
    self.nameLabel.text = notification.name;
    
    CGSize dateSize = [self getSizeWithString:notification.date font:self.dateLabel.font];
    CGRect dateRect = (CGRect){{CGRectGetMinX(nameRect),CGRectGetMaxY(nameRect) + margin_up}, dateSize};
    self.dateLabel.frame = dateRect;
    self.dateLabel.text = notification.date;
    
    CGSize titleSize = [self getSizeWithString:notification.title font:self.titleLabel.font];
    CGRect titleRect = (CGRect){{margin_left,CGRectGetMaxY(self.picImg.frame) + margin_up},titleSize};
    self.titleLabel.frame = titleRect;
    self.titleLabel.text = notification.title;
    
    CGSize messageSize = [self getSizeWithString:notification.message font:self.messageLabel.font];
    CGRect messageRect = (CGRect){{margin_left, CGRectGetMaxY(titleRect) + margin},messageSize};
    self.messageLabel.text = notification.message;
    self.messageLabel.frame = messageRect;
    CGFloat imgWidth = ([UIScreen mainScreen].bounds.size.width - margin_left * 2 - margin_up * 2) / 3;
    for (int i=0; i<notification.imgs.count; i++) {
        int row = i % 3;
        int lon = i / 3;
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.backgroundColor = [UIColor redColor];
        imgView.frame = CGRectMake(margin_left + row * (imgWidth + margin_up), CGRectGetMaxY(messageRect) + margin_up + lon * (margin_up + imgWidth), imgWidth, imgWidth);
        [self.contentView addSubview:imgView];
        self.cellHeight = CGRectGetMaxY(imgView.frame) + margin_bom;
    }
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor redColor];
    lineLabel.frame = CGRectMake(margin_left, self.cellHeight + margin, [UIScreen mainScreen].bounds.size.width - 20, 0.5);
    [self.contentView addSubview:lineLabel];
    if (notification.items && notification.items.count > 0) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(margin_left, CGRectGetMaxY(lineLabel.frame) + margin, 20, 20)];
        img.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:img];
        UILabel *commentAmountLabel = [[UILabel alloc] init];
        commentAmountLabel.font = Font_14;
        [self.contentView addSubview:commentAmountLabel];
        NSString *commentAmount = @"20条评论";
        CGSize size = [self getSizeWithString:commentAmount font:commentAmountLabel.font];
        CGRect commentRect = (CGRect){{CGRectGetMaxX(img.frame) + margin_up, CGRectGetMinY(img.frame)}, size};
        commentAmountLabel.frame = commentRect;
        commentAmountLabel.text = commentAmount;
        self.cellHeight = CGRectGetMaxY(commentRect) + margin_bom;
        
        
        
    }
    
    for (int i=0; i < notification.items.count; i++) {
        
    }
    
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
