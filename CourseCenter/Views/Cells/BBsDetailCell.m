//
//  BBsDetailCell.m
//  CourseCenter
//
//  Created by jian on 15/8/3.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "BBsDetailCell.h"
#import "UIImageView+WebCache.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface BBsDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIView *imgsView;
@property (weak, nonatomic) IBOutlet UIView *bomView1;
@property (weak, nonatomic) IBOutlet UIView *bomView2;
@property (weak, nonatomic) IBOutlet UIView *bomView3;

@property (weak, nonatomic) IBOutlet UILabel *eye;
@property (weak, nonatomic) IBOutlet UILabel *discuss;
@property (weak, nonatomic) IBOutlet UILabel *agree;
@property (weak, nonatomic) IBOutlet UIImageView *dicussImg;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property(nonatomic, assign) CGFloat ImgHeight;
@property(nonatomic, strong) NSMutableArray *imgViews;

@end

@implementation BBsDetailCell

- (void)awakeFromNib {
    self.bomView1.layer.borderColor = [UIColor grayColor].CGColor;
    self.bomView1.layer.borderWidth = 0.5f;
    self.bomView2.layer.borderColor = [UIColor grayColor].CGColor;
    self.bomView2.layer.borderWidth = 0.5f;
    self.bomView3.layer.borderColor = [UIColor grayColor].CGColor;
    self.bomView3.layer.borderWidth = 0.5f;
    self.content.preferredMaxLayoutWidth = Swidth - 10 - 10 -10;
    self.title.preferredMaxLayoutWidth = Swidth - 10 -10;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    self.agreeBlock();
}

- (void)tap:(UITapGestureRecognizer *)tap {
    UIImageView *imgView = (UIImageView *)tap.view;
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:self.topic.imgs.count];
    for (int i = 0; i<self.topic.imgs.count; i++) {
            // 替换为中等尺寸图片
        NSString *url = self.topic.imgs[i];
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
- (void)setTopic:(TopicInfo *)topic {
    _topic = topic;
    if (topic.imgs && topic.imgs.count > 0) {
        for (int i=0; i<self.imgViews.count; i++) {
            UIImageView *imgView = self.imgViews[i];
            [imgView removeFromSuperview];
        }
        for (NSLayoutConstraint *constraint in self.imgsView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                CGFloat width = (Swidth -20 -10 -10 - 18 - 4*10)/3;
                CGFloat height = (Swidth -20 -10 -10 -18 - 4*10)/3 + 20;
                CGFloat offset = 10;
                for (int i=0; i<topic.imgs.count; i++) {
                    int row = i % 3;
                    int lon = i / 3;
                    UIImageView *imgView = [[UIImageView alloc] init];
                    imgView.userInteractionEnabled = YES;
                    imgView.tag = i+ 10;
                    imgView.frame = CGRectMake(offset + row * (width + offset), offset + lon * (offset + height), width, height);
                    [imgView sd_setImageWithURL:[NSURL URLWithString:topic.imgs[i]]];
                    [self.imgsView addSubview:imgView];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
                    [imgView addGestureRecognizer:tap];
                    self.ImgHeight = CGRectGetMaxY(imgView.frame) + offset;
                    [self.imgsView addSubview:imgView];
                    [self.imgViews addObject:imgView];
                }
                
                constraint.constant = self.ImgHeight;
            }
        }
        
    } else {
        for (int i=0; i<self.imgViews.count; i++) {
            UIImageView *imgView = self.imgViews[i];
            [imgView removeFromSuperview];
        }
        for (NSLayoutConstraint *constraint in self.imgsView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 0;
            }
            
        }
        for (NSLayoutConstraint *constraint in self.contentView.constraints) {
            if (constraint.firstItem == self.imgsView && constraint.firstAttribute == NSLayoutAttributeTop) {
                constraint.constant = 0;
                
            }
        }
        
    }
    [self.img sd_setImageWithURL:[NSURL URLWithString:topic.userImg] placeholderImage:[UIImage imageNamed:@"me"]];
    self.title.text = topic.Title;
    self.content.text = topic.Conten;
    self.name.text = topic.UserName;
    self.className.text = topic.ForumClassName;
    NSArray *timeArray = [topic.UpdateTime componentsSeparatedByString:@"T"];
    NSArray *dateArray = [timeArray[0] componentsSeparatedByString:@"-"];
    NSString *dateStr = [NSString stringWithFormat:@"%@/%@",dateArray[1],dateArray[2]];
    NSArray *timesArray = [timeArray[1] componentsSeparatedByString:@":"];
    NSString *timeStr = [NSString stringWithFormat:@"%@:%@",timesArray[0],timesArray[1]];
    self.time.text = [NSString stringWithFormat:@"%@ %@",dateStr,timeStr];
    self.eye.text = [NSString stringWithFormat:@"%ld",topic.Clicks];
    self.discuss.text = [NSString stringWithFormat:@"%ld",topic.Responses];
    self.agree.text = [NSString stringWithFormat:@"%ld",topic.Goods];
    if (topic.IsGood) {
        [self.agreeBtn setImage:[UIImage imageNamed:@"icon_agree_push"] forState:UIControlStateNormal];
    } else {
        [self.agreeBtn setImage:[UIImage imageNamed:@"icon_agree"] forState:UIControlStateNormal];
    }

}
- (IBAction)agreeAction:(id)sender {
    self.agreeBlock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
