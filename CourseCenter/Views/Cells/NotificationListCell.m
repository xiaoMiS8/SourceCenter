//
//  NotificationListCell.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NotificationListCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+HandleString.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

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
@property(nonatomic, strong) UILabel *topLine;
@property(nonatomic, strong) UILabel *bomLine;

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
                       font:(UIFont *)font size:(CGSize)size {
    CGSize stringSize = [string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName: font} context:nil].size;
    return stringSize;
}

- (void)initView {
    
    if (self.topLine == nil) {
        self.topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
        self.topLine.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.topLine];
    }
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
    if (self.bomLine == nil) {
        self.bomLine = [[UILabel alloc] init];
        self.bomLine.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.bomLine];
    }
   
}

- (void)tap:(UITapGestureRecognizer *)tap {
    UIImageView *imgView = (UIImageView *)tap.view;
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:self.noticeInfo.imgs.count];
    for (int i = 0; i<self.noticeInfo.imgs.count; i++) {
            // 替换为中等尺寸图片
        NSString *url = self.noticeInfo.imgs[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        photo.srcImageView = (UIImageView *)[self.contentView viewWithTag:i + 10]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }

    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = imgView.tag - 10; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}


- (void)setNoticeInfo:(NoticeInfo *)noticeInfo {
    _noticeInfo = noticeInfo;
    NSString *imgName = @"iconpro";
    if (noticeInfo.Gender !=2) {
        imgName = @"me";
    }
    [self.picImg sd_setImageWithURL:[NSURL URLWithString:noticeInfo.UserImg] placeholderImage:[UIImage imageNamed:imgName]];
    CGSize nameSize = [self getSizeWithString:noticeInfo.UserName font:self.nameLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, CGFLOAT_MAX)];
    CGRect nameRect = (CGRect){{CGRectGetMaxX(self.picImg.frame) + margin, CGRectGetMinY(self.picImg.frame) + 4}, nameSize};
    self.nameLabel.frame = nameRect;
    self.nameLabel.text = noticeInfo.UserName;
    
    CGSize dateSize = [self getSizeWithString:noticeInfo.UpdateTime font:self.dateLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, CGFLOAT_MAX)];
    CGRect dateRect = (CGRect){{CGRectGetMinX(nameRect),CGRectGetMaxY(nameRect) + margin_up}, dateSize};
    self.dateLabel.frame = dateRect;
    NSArray *timeArray = [noticeInfo.UpdateTime componentsSeparatedByString:@"T"];
    NSArray *dateArray = [timeArray[0] componentsSeparatedByString:@"-"];
    NSString *dateStr = [NSString stringWithFormat:@"%@/%@",dateArray[1],dateArray[2]];
    NSArray *timesArray = [timeArray[1] componentsSeparatedByString:@":"];
    NSString *timeStr = [NSString stringWithFormat:@"%@:%@",timesArray[0],timesArray[1]];
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %@",dateStr,timeStr];
    
    CGSize titleSize = [self getSizeWithString:noticeInfo.Title font:self.titleLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, CGFLOAT_MAX)];
    CGRect titleRect = (CGRect){{margin_left,CGRectGetMaxY(self.picImg.frame) + margin},titleSize};
    self.titleLabel.frame = titleRect;
    self.titleLabel.text = noticeInfo.Title;
    
    CGSize messageSize = [self getSizeWithString:noticeInfo.Conten font:self.messageLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, CGFLOAT_MAX)];
    CGRect messageRect = (CGRect){{margin_left, CGRectGetMaxY(titleRect) + margin},messageSize};
    self.messageLabel.text = noticeInfo.Conten;
    self.messageLabel.frame = messageRect;
    self.cellHeight = CGRectGetMaxY(messageRect) + margin_bom;
    CGFloat imgWidth = ([UIScreen mainScreen].bounds.size.width - margin_left * 2 - margin_up * 2) / 3;
    for (int i=0; i< self.imgs.count; i++) {
        UIImageView *img = self.imgs[i];
        [img removeFromSuperview];
        img = nil;
    }
    for (int i=0; i<noticeInfo.imgs.count; i++) {
//        imgInfo *imgInfo = noticeInfo.imgs[i];
        NSString *imgurl = noticeInfo.imgs[i];
        int row = i % 3;
        int lon = i / 3;
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.tag = i + 10;
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imgView addGestureRecognizer:tap];
        imgView.frame = CGRectMake(margin_left + row * (imgWidth + margin_up), CGRectGetMaxY(messageRect) + margin + lon * (margin_up + imgWidth), imgWidth, imgWidth);
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgurl]];
        [self.contentView addSubview:imgView];
        self.cellHeight = CGRectGetMaxY(imgView.frame) + margin_bom;
        [self.imgs addObject:imgView];
    }
    if (!self.isDetail) {
        if (noticeInfo.NoticeResponse && noticeInfo.NoticeResponse.count > 0) {
            if (self.lineLabel == nil) {
                UILabel *lineLabel = [[UILabel alloc] init];
                lineLabel.backgroundColor = [UIColor grayColor];
                [self.contentView addSubview:lineLabel];
                self.lineLabel = lineLabel;
            }
            self.lineLabel.frame = CGRectMake(margin_left, self.cellHeight, [UIScreen mainScreen].bounds.size.width - 20, 0.5);
            if (self.iconImg == nil) {
                UIImageView *img = [[UIImageView alloc] init];
                    //            img.backgroundColor = [UIColor redColor];
                img.image = [UIImage imageNamed:@"discuss"];
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
            NSString *commentAmount = [NSString stringWithFormat:@"%d条评论",noticeInfo.ResponseCount];
            CGSize size = [self getSizeWithString:commentAmount font:self.commentLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, CGFLOAT_MAX)];
            CGRect commentRect = (CGRect){{CGRectGetMaxX(self.iconImg.frame) + margin_up, CGRectGetMinY(self.iconImg.frame) - margin_up}, size};
            self.commentLabel.frame = commentRect;
            self.commentLabel.text = commentAmount;
            self.cellHeight = CGRectGetMaxY(commentRect) + margin;
            for (int i=0; i< self.items.count; i++) {
                UIView *view = self.items[i];
                [view removeFromSuperview];
                view = nil;
            }
            for (int i=0; i<noticeInfo.NoticeResponse.count; i++) {
                
                NoticeResponseInfo *noticeRespone = noticeInfo.NoticeResponse[i];
                UIView *bgView = [[UIView alloc] init];
                    //            bgView.backgroundColor = [UIColor brownColor];
                [self.contentView addSubview:bgView];
                UILabel *inameLabel = [[UILabel alloc] init];
                inameLabel.font = Font_12;
                [bgView addSubview:inameLabel];
                
                UILabel *icontentLabel = [[UILabel alloc] init];
                icontentLabel.font = Font_12;
                icontentLabel.numberOfLines = 0;
                [bgView addSubview:icontentLabel];
                NSString *nameStr = [NSString stringWithFormat:@"%@: ",noticeRespone.UserName];
                NSString *contentStr = nil;
                if (noticeRespone.toName == nil) {
                    contentStr = noticeRespone.Conten;
                    icontentLabel.textColor = [UIColor blackColor];
                } else {
                    contentStr = [NSString stringWithFormat:@"@%@: %@",noticeRespone.toName,noticeRespone.Conten];
                    icontentLabel.textColor = [UIColor grayColor];
                }
                NSString *string = nil;
                if (noticeRespone.toName == nil) {
                    string = [NSString stringWithFormat:@"%@: %@",noticeRespone.UserName,noticeRespone.Conten];
                } else {
                    string = [NSString stringWithFormat:@"%@: @%@: %@",noticeRespone.UserName,noticeRespone.toName,noticeRespone.Conten];
                }
                CGSize nameSize = [self getSizeWithString:nameStr font:inameLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)];
                CGSize contentSize = [self getSizeWithString:contentStr font:icontentLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40 - nameSize.width, CGFLOAT_MAX)];
                CGRect inameRect = (CGRect){{0, 0}, nameSize};
                CGRect icontentRect = (CGRect){{CGRectGetMaxX(inameRect), 0},contentSize};
                CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, contentSize.height);
                CGRect rect = (CGRect){{margin_left * 3,self.cellHeight
                },size};
                bgView.frame = rect;
                inameLabel.frame = inameRect;
                icontentLabel.frame = icontentRect;
                inameLabel.text = nameStr;
                icontentLabel.text = contentStr;
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
    self.bomLine.frame = CGRectMake(0, self.cellHeight, [UIScreen mainScreen].bounds.size.width, 0.5);
    self.cellHeight += margin_bom;

}

- (void)setNoticeRespones:(NSArray *)noticeRespones {
    _noticeRespones = noticeRespones;
    if (noticeRespones && noticeRespones.count > 0) {
        if (self.lineLabel == nil) {
            UILabel *lineLabel = [[UILabel alloc] init];
            lineLabel.backgroundColor = [UIColor grayColor];
            [self.contentView addSubview:lineLabel];
            self.lineLabel = lineLabel;
        }
        self.lineLabel.frame = CGRectMake(margin_left, self.cellHeight, [UIScreen mainScreen].bounds.size.width - 20, 0.5);
        if (self.iconImg == nil) {
            UIImageView *img = [[UIImageView alloc] init];
                //            img.backgroundColor = [UIColor redColor];
            img.image = [UIImage imageNamed:@"discuss"];
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
        NSString *commentAmount = [NSString stringWithFormat:@"%d条评论",self.noticeInfo.ResponseCount];
        CGSize size = [self getSizeWithString:commentAmount font:self.commentLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, CGFLOAT_MAX)];
        CGRect commentRect = (CGRect){{CGRectGetMaxX(self.iconImg.frame) + margin_up, CGRectGetMinY(self.iconImg.frame) - margin_up}, size};
        self.commentLabel.frame = commentRect;
        self.commentLabel.text = commentAmount;
        self.cellHeight = CGRectGetMaxY(commentRect) + margin;
        for (int i=0; i< self.items.count; i++) {
            UIView *view = self.items[i];
            [view removeFromSuperview];
            view = nil;
        }
        for (int i=0; i<noticeRespones.count; i++) {
            
            NoticeResponseInfo *noticeRespone = noticeRespones[i];
            UIView *bgView = [[UIView alloc] init];
                //            bgView.backgroundColor = [UIColor brownColor];
            [self.contentView addSubview:bgView];
            UILabel *inameLabel = [[UILabel alloc] init];
            inameLabel.font = Font_12;
            [bgView addSubview:inameLabel];
            
            UILabel *icontentLabel = [[UILabel alloc] init];
            icontentLabel.font = Font_12;
            icontentLabel.numberOfLines = 0;
            [bgView addSubview:icontentLabel];
            NSString *nameStr = [NSString stringWithFormat:@"%@: ",noticeRespone.UserName];
            NSString *contentStr = nil;
            if (noticeRespone.toName == nil) {
                contentStr = noticeRespone.Conten;
                icontentLabel.textColor = [UIColor blackColor];
            } else {
                contentStr = [NSString stringWithFormat:@"@%@: %@",noticeRespone.toName,noticeRespone.Conten];
                icontentLabel.textColor = [UIColor grayColor];
            }
            NSString *string = nil;
            if (noticeRespone.toName == nil) {
                string = [NSString stringWithFormat:@"%@: %@",noticeRespone.UserName,noticeRespone.Conten];
            } else {
                string = [NSString stringWithFormat:@"%@: @%@: %@",noticeRespone.UserName,noticeRespone.toName,noticeRespone.Conten];
            }
            CGSize nameSize = [self getSizeWithString:nameStr font:inameLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)];
            CGSize contentSize = [self getSizeWithString:contentStr font:icontentLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40 - nameSize.width, CGFLOAT_MAX)];
            CGRect inameRect = (CGRect){{0, 0}, nameSize};
            CGRect icontentRect = (CGRect){{CGRectGetMaxX(inameRect), 0},contentSize};
            CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, contentSize.height);
            CGRect rect = (CGRect){{margin_left * 3,self.cellHeight
            },size};
            bgView.frame = rect;
            inameLabel.frame = inameRect;
            icontentLabel.frame = icontentRect;
            inameLabel.text = nameStr;
            icontentLabel.text = contentStr;
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
    self.bomLine.frame = CGRectMake(0, self.cellHeight, [UIScreen mainScreen].bounds.size.width, 0.5);
    self.cellHeight += margin_bom;

}

//- (void)setNotification:(NotificationInfo *)notification {
//    _notification = notification;
//    [self.picImg sd_setImageWithURL:[NSURL URLWithString:@"https://drscdn.500px.org/photo/110153683/w%3D140_h%3D140/fcd565c07a9039590ceb79855050dba3?v=2"]];
//    CGSize nameSize = [self getSizeWithString:notification.name font:self.nameLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, CGFLOAT_MAX)];
//    CGRect nameRect = (CGRect){{CGRectGetMaxX(self.picImg.frame) + margin, CGRectGetMinY(self.picImg.frame) + 4}, nameSize};
//    self.nameLabel.frame = nameRect;
//    self.nameLabel.text = notification.name;
//    
//    CGSize dateSize = [self getSizeWithString:notification.date font:self.dateLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, CGFLOAT_MAX)];
//    CGRect dateRect = (CGRect){{CGRectGetMinX(nameRect),CGRectGetMaxY(nameRect) + margin_up}, dateSize};
//    self.dateLabel.frame = dateRect;
//    self.dateLabel.text = notification.date;
//    
//    CGSize titleSize = [self getSizeWithString:notification.title font:self.titleLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, CGFLOAT_MAX)];
//    CGRect titleRect = (CGRect){{margin_left,CGRectGetMaxY(self.picImg.frame) + margin},titleSize};
//    self.titleLabel.frame = titleRect;
//    self.titleLabel.text = notification.title;
//    
//    CGSize messageSize = [self getSizeWithString:notification.message font:self.messageLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, CGFLOAT_MAX)];
//    CGRect messageRect = (CGRect){{margin_left, CGRectGetMaxY(titleRect) + margin},messageSize};
//    self.messageLabel.text = notification.message;
//    self.messageLabel.frame = messageRect;
//    self.cellHeight = CGRectGetMaxY(messageRect) + margin_bom;
//    CGFloat imgWidth = ([UIScreen mainScreen].bounds.size.width - margin_left * 2 - margin_up * 2) / 3;
//    for (int i=0; i< self.imgs.count; i++) {
//        UIImageView *img = self.imgs[i];
//        [img removeFromSuperview];
//        img = nil;
//    }
//    for (int i=0; i<notification.imgs.count; i++) {
//        imgInfo *imgInfo = notification.imgs[i];
//        int row = i % 3;
//        int lon = i / 3;
//        UIImageView *imgView = [[UIImageView alloc] init];
//        imgView.backgroundColor = [UIColor redColor];
//        imgView.frame = CGRectMake(margin_left + row * (imgWidth + margin_up), CGRectGetMaxY(messageRect) + margin + lon * (margin_up + imgWidth), imgWidth, imgWidth);
//        [imgView sd_setImageWithURL:[NSURL URLWithString:imgInfo.url]];
//        [self.contentView addSubview:imgView];
//        self.cellHeight = CGRectGetMaxY(imgView.frame) + margin_bom;
//        [self.imgs addObject:imgView];
//    }
//    
//    if (notification.items && notification.items.count > 0) {
//        if (self.lineLabel == nil) {
//            UILabel *lineLabel = [[UILabel alloc] init];
//            lineLabel.backgroundColor = [UIColor grayColor];
//            [self.contentView addSubview:lineLabel];
//            self.lineLabel = lineLabel;
//        }
//       self.lineLabel.frame = CGRectMake(margin_left, self.cellHeight, [UIScreen mainScreen].bounds.size.width - 20, 0.5);
//        if (self.iconImg == nil) {
//            UIImageView *img = [[UIImageView alloc] init];
////            img.backgroundColor = [UIColor redColor];
//            img.image = [UIImage imageNamed:@"discuss"];
//            [self.contentView addSubview:img];
//            self.iconImg = img;
//        }
//        self.iconImg.frame = CGRectMake(margin_left, CGRectGetMaxY(self.lineLabel.frame) + margin, 16, 16);
//        if (self.commentLabel == nil) {
//            UILabel *commentAmountLabel = [[UILabel alloc] init];
//            commentAmountLabel.font = Font_14;
//            [self.contentView addSubview:commentAmountLabel];
//            self.commentLabel = commentAmountLabel;
//           
//        }
//        NSString *commentAmount = [NSString stringWithFormat:@"%ld条评论",notification.items.count];
//        CGSize size = [self getSizeWithString:commentAmount font:self.commentLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, CGFLOAT_MAX)];
//        CGRect commentRect = (CGRect){{CGRectGetMaxX(self.iconImg.frame) + margin_up, CGRectGetMinY(self.iconImg.frame) - margin_up}, size};
//        self.commentLabel.frame = commentRect;
//        self.commentLabel.text = commentAmount;
//        self.cellHeight = CGRectGetMaxY(commentRect) + margin;
//        for (int i=0; i< self.items.count; i++) {
//            UIView *view = self.items[i];
//            [view removeFromSuperview];
//            view = nil;
//        }
//        for (int i=0; i<notification.items.count; i++) {
//            
//            Item *item = notification.items[i];
//            UIView *bgView = [[UIView alloc] init];
////            bgView.backgroundColor = [UIColor brownColor];
//            [self.contentView addSubview:bgView];
//            UILabel *inameLabel = [[UILabel alloc] init];
//            inameLabel.font = Font_12;
//            [bgView addSubview:inameLabel];
//            
//            UILabel *icontentLabel = [[UILabel alloc] init];
//            icontentLabel.font = Font_12;
//            icontentLabel.numberOfLines = 0;
//            [bgView addSubview:icontentLabel];
//            NSString *nameStr = [NSString stringWithFormat:@"%@: ",item.itemName];
//            NSString *contentStr = nil;
//            if (item.toName == nil) {
//                contentStr = item.itemContent;
//                icontentLabel.textColor = [UIColor blackColor];
//            } else {
//                contentStr = [NSString stringWithFormat:@"@%@: %@",item.toName,item.itemContent];
//                icontentLabel.textColor = [UIColor grayColor];
//            }
//            NSString *string = nil;
//            if (item.toName == nil) {
//                string = [NSString stringWithFormat:@"%@: %@",item.itemName,item.itemContent];
//            } else {
//                string = [NSString stringWithFormat:@"%@: @%@: %@",item.itemName,item.toName,item.itemContent];
//            }
//            CGSize nameSize = [self getSizeWithString:nameStr font:inameLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)];
//            CGSize contentSize = [self getSizeWithString:contentStr font:icontentLabel.font size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 40 - nameSize.width, CGFLOAT_MAX)];
//            CGRect inameRect = (CGRect){{0, 0}, nameSize};
//            CGRect icontentRect = (CGRect){{CGRectGetMaxX(inameRect), 0},contentSize};
//            CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, contentSize.height);
//            CGRect rect = (CGRect){{margin_left * 3,self.cellHeight
//            },size};
//            bgView.frame = rect;
//            inameLabel.frame = inameRect;
//            icontentLabel.frame = icontentRect;
//            inameLabel.text = nameStr;
//            icontentLabel.text = contentStr;
//            self.cellHeight = CGRectGetMaxY(bgView.frame) + margin;
//            [self.items addObject:bgView];
//        }
//        
//        
//    } else {
//        [self.iconImg removeFromSuperview];
//        self.iconImg = nil;
//        [self.commentLabel removeFromSuperview];
//        self.commentLabel = nil;
//        for (UIView *view in self.items) {
//            [view removeFromSuperview];
//        }
//        [self.lineLabel removeFromSuperview];
//        self.lineLabel = nil;
//    }
//    
//    self.bomLine.frame = CGRectMake(0, self.cellHeight, [UIScreen mainScreen].bounds.size.width, 0.5);
//    self.cellHeight += margin_bom;
//    
//   
//}

- (void)setFrame:(CGRect)frame {
     frame.size.height -= margin_bom;
    [super setFrame:frame];
   
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
