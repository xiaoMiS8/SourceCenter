//
//  BBSListCell.m
//  CourseCenter
//
//  Created by jian on 15/8/2.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "BBSListCell.h"
#import "UIImageView+WebCache.h"

@interface BBSListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *essenceImg;
@property (weak, nonatomic) IBOutlet UIImageView *topImg;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *eye;
@property (weak, nonatomic) IBOutlet UILabel *discuss;
@property (weak, nonatomic) IBOutlet UILabel *agree;
@property (weak, nonatomic) IBOutlet UIView *bomView1;
@property (weak, nonatomic) IBOutlet UIView *bomView2;
@property (weak, nonatomic) IBOutlet UIView *bomView3;
@property (weak, nonatomic) IBOutlet UIView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *agreeImg;
@property(nonatomic, assign) CGFloat ImgHeight;
@property(nonatomic, strong) NSMutableArray *imgViews;

@end

@implementation BBSListCell

- (void)awakeFromNib {
    self.bomView1.layer.borderColor = [UIColor grayColor].CGColor;
    self.bomView1.layer.borderWidth = 0.5f;
    self.bomView2.layer.borderColor = [UIColor grayColor].CGColor;
    self.bomView2.layer.borderWidth = 0.5f;
    self.bomView3.layer.borderColor = [UIColor grayColor].CGColor;
    self.bomView3.layer.borderWidth = 0.5f;
    self.imgViews = [[NSMutableArray alloc] initWithCapacity:0];
}

- (void)setTopic:(TopicInfo *)topic {
    _topic = topic;
    if (topic.imgs && topic.imgs.count > 0) {
        for (int i=0; i<self.imgViews.count; i++) {
            UIImageView *imgView = self.imgViews[i];
            [imgView removeFromSuperview];
        }
        for (NSLayoutConstraint *constraint in self.imgView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                CGFloat width = (Swidth -20 -10 -10 - 18 - 4*10)/3;
                CGFloat height = (Swidth -20 -10 -10 -18 - 4*10)/3 + 20;
                CGFloat offset = 10;
                for (int i=0; i<topic.imgs.count; i++) {
                    int row = i % 3;
                    int lon = i / 3;
                    UIImageView *imgView = [[UIImageView alloc] init];
                    imgView.frame = CGRectMake(offset + row * (width + offset), offset + lon * (offset + height), width, height);
                    [imgView sd_setImageWithURL:[NSURL URLWithString:@"http://image.kuwo.cn/artistxz/default_160.jpg"]];
                    [self.imgView addSubview:imgView];
                    self.ImgHeight = CGRectGetMaxY(imgView.frame) + offset;
                    [self.imgView addSubview:imgView];
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
        for (NSLayoutConstraint *constraint in self.imgView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 0;
            }
            
        }
        for (NSLayoutConstraint *constraint in self.contentView.constraints) {
            if (constraint.firstItem == self.imgView && constraint.firstAttribute == NSLayoutAttributeTop) {
                 constraint.constant = 0;
               
            }
        }
        
    }
    if (topic.IsEssence && topic.IsTop) {
        for (NSLayoutConstraint *constraint in self.essenceImg.constraints) {
            if ( constraint.firstItem == self.essenceImg &&constraint.firstAttribute == NSLayoutAttributeWidth) {
                constraint.constant = 26;
            }
            if ( constraint.firstItem == self.essenceImg &&constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 26;
            }
        }
        for (NSLayoutConstraint *constraint in self.contentView.constraints) {
            if ( constraint.firstItem ==self.topImg &&constraint.firstAttribute == NSLayoutAttributeLeading) {
                constraint.constant = 8;
            }
        }
        for (NSLayoutConstraint *constraint in self.topImg.constraints) {
            if ( constraint.firstItem == self.topImg &&constraint.firstAttribute == NSLayoutAttributeWidth) {
                constraint.constant = 26;
            }
            if ( constraint.firstItem == self.topImg &&constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 26;
            }
        }
        for (NSLayoutConstraint *constraint in self.contentView.constraints) {
            if ( constraint.firstItem ==self.title &&constraint.firstAttribute == NSLayoutAttributeLeading) {
                constraint.constant = 8;
            }
        }

    } else if (topic.IsEssence && !topic.IsTop) {
        for (NSLayoutConstraint *constraint in self.topImg.constraints) {
            if ( constraint.firstItem == self.topImg &&constraint.firstAttribute == NSLayoutAttributeWidth) {
                constraint.constant = 0;
            }
            if ( constraint.firstItem == self.topImg &&constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 0;
            }
        }
        for (NSLayoutConstraint *constraint in self.contentView.constraints) {
            if ( constraint.firstItem ==self.topImg &&constraint.firstAttribute == NSLayoutAttributeLeading) {
                constraint.constant = 0;
            }
        }
    } else if (!topic.IsEssence && topic.IsTop) {
        for (NSLayoutConstraint *constraint in self.essenceImg.constraints) {
            if ( constraint.firstItem == self.essenceImg &&constraint.firstAttribute == NSLayoutAttributeWidth) {
                constraint.constant = 0;
            }
            if ( constraint.firstItem == self.essenceImg &&constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 0;
            }
        }
        for (NSLayoutConstraint *constraint in self.contentView.constraints) {
            if ( constraint.firstItem ==self.topImg &&constraint.firstAttribute == NSLayoutAttributeLeading) {
                constraint.constant = 0;
            }
        }
    } else {
        for (NSLayoutConstraint *constraint in self.essenceImg.constraints) {
            if ( constraint.firstItem == self.essenceImg &&constraint.firstAttribute == NSLayoutAttributeWidth) {
                constraint.constant = 0;
            }
            if ( constraint.firstItem == self.essenceImg &&constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 0;
            }
        }
        for (NSLayoutConstraint *constraint in self.contentView.constraints) {
            if ( constraint.firstItem ==self.topImg &&constraint.firstAttribute == NSLayoutAttributeLeading) {
                constraint.constant = 0;
            }
        }
        for (NSLayoutConstraint *constraint in self.topImg.constraints) {
            if ( constraint.firstItem == self.topImg &&constraint.firstAttribute == NSLayoutAttributeWidth) {
                constraint.constant = 0;
            }
            if ( constraint.firstItem == self.topImg &&constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 0;
            }
        }
        for (NSLayoutConstraint *constraint in self.contentView.constraints) {
            if ( constraint.firstItem ==self.title &&constraint.firstAttribute == NSLayoutAttributeLeading) {
                constraint.constant = 0;
            }
        }
    }
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
        self.agreeImg.image = [UIImage imageNamed:@"icon_agree_push"];
    } else {
        self.agreeImg.image = [UIImage imageNamed:@"icon_agree"];
    }
}
- (IBAction)agreeClick:(id)sender {
    if (self.agreeBlock) {
        self.agreeBlock();
    }
}
- (IBAction)btnAction:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  
}

@end
