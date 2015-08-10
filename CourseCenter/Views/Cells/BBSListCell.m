//
//  BBSListCell.m
//  CourseCenter
//
//  Created by jian on 15/8/2.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "BBSListCell.h"

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

@end

@implementation BBSListCell

- (void)awakeFromNib {
    self.bomView1.layer.borderColor = [UIColor grayColor].CGColor;
    self.bomView1.layer.borderWidth = 0.5f;
    self.bomView2.layer.borderColor = [UIColor grayColor].CGColor;
    self.bomView2.layer.borderWidth = 0.5f;
    self.bomView3.layer.borderColor = [UIColor grayColor].CGColor;
    self.bomView3.layer.borderWidth = 0.5f;
}

- (void)setTopic:(TopicInfo *)topic {
    _topic = topic;
    if (topic.imgs && topic.imgs.count > 0) {
        for (NSLayoutConstraint *constraint in self.imgView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 280;
            }
        }
        
    } else {
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
    self.time.text = topic.UpdateTime;
    self.eye.text = [NSString stringWithFormat:@"%ld",topic.Clicks];
    self.discuss.text = [NSString stringWithFormat:@"%ld",topic.Responses];
    self.agree.text = [NSString stringWithFormat:@"%ld",topic.Goods];
    if (topic.IsGood) {
        self.agreeImg.image = [UIImage imageNamed:@"icon_agree_push"];
    } else {
        self.agreeImg.image = [UIImage imageNamed:@"icon_agree"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  
}

@end
