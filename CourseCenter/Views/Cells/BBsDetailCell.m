//
//  BBsDetailCell.m
//  CourseCenter
//
//  Created by jian on 15/8/3.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "BBsDetailCell.h"
#import "UIImageView+WebCache.h"

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

@end

@implementation BBsDetailCell

- (void)awakeFromNib {
    self.bomView1.layer.borderColor = [UIColor grayColor].CGColor;
    self.bomView1.layer.borderWidth = 0.5f;
    self.bomView2.layer.borderColor = [UIColor grayColor].CGColor;
    self.bomView2.layer.borderWidth = 0.5f;
    self.bomView3.layer.borderColor = [UIColor grayColor].CGColor;
    self.bomView3.layer.borderWidth = 0.5f;
    self.content.preferredMaxLayoutWidth = Swidth - 10 - 10;
    self.title.preferredMaxLayoutWidth = Swidth - 10 -10;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    self.agreeBlock();
}

- (void)setTopic:(TopicInfo *)topic {
    _topic = topic;
    if (topic.imgs && topic.imgs.count > 0) {
        for (NSLayoutConstraint *constraint in self.imgsView.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                constraint.constant = 280;
            }
        }
        
    } else {
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
    [self.img sd_setImageWithURL:[NSURL URLWithString:topic.userImg] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
    self.title.text = topic.Title;
    self.content.text = topic.Conten;
    self.name.text = topic.UserName;
    self.className.text = topic.ForumClassName;
    NSArray *timeArray = [topic.UpdateTime componentsSeparatedByString:@"T"];
    self.time.text = [NSString stringWithFormat:@"%@ %@",timeArray[0],timeArray[1]];
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
