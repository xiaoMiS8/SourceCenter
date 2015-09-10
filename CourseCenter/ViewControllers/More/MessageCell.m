//
//  MessageCell.m
//  CourseCenter
//
//  Created by 2345 on 15/7/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MessageCell.h"
#import "CellFrameModel.h"
#import "MessageModel.h"
#import "UIImage+ResizeImage.h"
#import "MsgInfo.h"
#import "UIImageView+WebCache.h"
#import "NSString+HandleString.h"

@interface MessageCell()
{
    UILabel *_timeLabel;
    UIImageView *_iconView;
    UIButton *_textView;
    UIImageView *_imgView;
}
@end

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_timeLabel];
        
        _iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconView];
        
        _textView = [UIButton buttonWithType:UIButtonTypeCustom];
        _textView.titleLabel.numberOfLines = 0;
        _textView.titleLabel.font = [UIFont systemFontOfSize:13];
        _textView.contentEdgeInsets = UIEdgeInsetsMake(textPadding, textPadding, textPadding, textPadding);
        [self.contentView addSubview:_textView];
        
        _imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:_imgView];
    }
    return self;
}

- (void)setCellFrame:(CellFrameModel *)cellFrame
{
    _cellFrame = cellFrame;
    MessageModel *message = cellFrame.message;
    
    _timeLabel.frame = cellFrame.timeFrame;
    _timeLabel.text = message.time;
    
    _iconView.frame = cellFrame.iconFrame;
    if(message.type==kMessageModelTypeOther)
    {
      [ _iconView sd_setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userImg"]] placeholderImage:[UIImage imageNamed:@"other"]];
    }else
    {
       [ _iconView sd_setImageWithURL:[NSURL URLWithString:((MsgInfo *)_dic).UserImgUrl] placeholderImage:[UIImage imageNamed:@"other"]];
    }
//    NSString *iconStr = message.type ? @"other" : @"me";
//    _iconView.image = [UIImage imageNamed:iconStr];
    
    if (message.imgurl.count==0) {
        _textView.frame = cellFrame.textFrame;
        NSString *textBg = message.type==kMessageModelTypeMe ? @"chat_recive_nor" : @"chat_send_nor";
        UIColor *textColor = message.type==kMessageModelTypeMe ? [UIColor blackColor] : [UIColor whiteColor];
        [_textView setTitleColor:textColor forState:UIControlStateNormal];
        [_textView setBackgroundImage:[UIImage resizeImage:textBg] forState:UIControlStateNormal];
        [_textView setTitle:message.text forState:UIControlStateNormal];
    }else
    {
        _imgView.frame = cellFrame.textFrame;
        [_imgView sd_setImageWithURL:[NSURL URLWithString:message.imgurl[0]]];
    }
    
}

@end
