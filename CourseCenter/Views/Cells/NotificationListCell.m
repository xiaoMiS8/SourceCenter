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
@property(nonatomic, strong) UIImageView *iconImg;
@property(nonatomic, strong) UILabel *commentLabel;
@property(nonatomic, strong) UILabel *lineLabel;
@property(nonatomic, strong) NSMutableArray *imgs;
@property(nonatomic, strong) NSMutableArray *items;

@end

@implementation NotificationListCell

- (void)awakeFromNib {
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        self.items = [[NSMutableArray alloc] init];
        self.imgs = [[NSMutableArray alloc] init];
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
    if (self.picImg == nil) {
        self.picImg = [[UIImageView alloc] initWithFrame:CGRectMake(margin_left, margin_left, 50, 50)];
        self.picImg.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.picImg];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = Font_16;
        [self.contentView addSubview:self.nameLabel];
    }
    if (self.dateLabel == nil) {
        self.dateLabel = [[UILabel alloc] init];
        self.dateLabel.font = Font_16;
        [self.contentView addSubview:self.dateLabel];
    }
    if (self.titleLabel == nil) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = Font_16;
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
    }
    if (self.messageLabel == nil) {
        self.messageLabel = [[UILabel alloc] init];
        self.messageLabel.font = Font_14;
        self.messageLabel.numberOfLines = 0;
        [self.contentView addSubview:self.messageLabel];
    }
   
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
    self.cellHeight = CGRectGetMaxY(messageRect) + margin_bom;
    CGFloat imgWidth = ([UIScreen mainScreen].bounds.size.width - margin_left * 2 - margin_up * 2) / 3;
    for (int i=0; i< self.imgs.count; i++) {
        UIImageView *img = self.imgs[i];
        [img removeFromSuperview];
        img = nil;
    }
    for (int i=0; i<notification.imgs.count; i++) {
        int row = i % 3;
        int lon = i / 3;
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.backgroundColor = [UIColor redColor];
        imgView.frame = CGRectMake(margin_left + row * (imgWidth + margin_up), CGRectGetMaxY(messageRect) + margin + lon * (margin_up + imgWidth), imgWidth, imgWidth);
        [self.contentView addSubview:imgView];
        self.cellHeight = CGRectGetMaxY(imgView.frame) + margin_bom;
        [self.imgs addObject:imgView];
    }
    
    if (notification.items && notification.items.count > 0) {
        if (self.lineLabel == nil) {
            UILabel *lineLabel = [[UILabel alloc] init];
            lineLabel.backgroundColor = [UIColor redColor];
            [self.contentView addSubview:lineLabel];
            self.lineLabel = lineLabel;
        }
       self.lineLabel.frame = CGRectMake(margin_left, self.cellHeight, [UIScreen mainScreen].bounds.size.width - 20, 0.5);
        if (self.iconImg == nil) {
            UIImageView *img = [[UIImageView alloc] init];
            img.backgroundColor = [UIColor redColor];
            [self.contentView addSubview:img];
            self.iconImg = img;
        }
        self.iconImg.frame = CGRectMake(margin_left, CGRectGetMaxY(self.lineLabel.frame) + margin, 16, 16);
        if (self.commentLabel == nil) {
            UILabel *commentAmountLabel = [[UILabel alloc] init];
            commentAmountLabel.font = Font_14;
            [self.contentView addSubview:commentAmountLabel];
            self.commentLabel = commentAmountLabel;
           
        }
        NSString *commentAmount = @"20条评论";
        CGSize size = [self getSizeWithString:commentAmount font:self.commentLabel.font];
        CGRect commentRect = (CGRect){{CGRectGetMaxX(self.iconImg.frame) + margin_up, CGRectGetMinY(self.iconImg.frame)}, size};
        self.commentLabel.frame = commentRect;
        self.commentLabel.text = commentAmount;
        self.cellHeight = CGRectGetMaxY(commentRect) + margin;
        for (int i=0; i< self.items.count; i++) {
            UIView *view = self.items[i];
            [view removeFromSuperview];
            view = nil;
        }
        for (int i=0; i<notification.items.count; i++) {
            UIView *bgView = [[UIView alloc] init];
            bgView.backgroundColor = [UIColor brownColor];
            [self.contentView addSubview:bgView];
            UILabel *label = [[UILabel alloc] init];
            label.font = Font_12;
            label.numberOfLines = 0;
            [bgView addSubview:label];
            CGSize size = [self getSizeWithString:notification.items[i] font:label.font];
            CGRect rect = (CGRect){{margin_left,self.cellHeight
            },size};
            bgView.frame = rect;
            label.frame = (CGRect){{0,0},size};
            label.text = notification.items[i];
            self.cellHeight = CGRectGetMaxY(bgView.frame) + margin;
            [self.items addObject:bgView];
        }
        
        
    } else {
        [self.iconImg removeFromSuperview];
        self.iconImg = nil;
        [self.commentLabel removeFromSuperview];
        self.commentLabel = nil;
        for (UIView *view in self.items) {
            [view removeFromSuperview];
        }
        [self.lineLabel removeFromSuperview];
        self.lineLabel = nil;
    }
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
