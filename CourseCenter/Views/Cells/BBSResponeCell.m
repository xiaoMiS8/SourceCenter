//
//  BBSResponeCell.m
//  CourseCenter
//
//  Created by jian on 15/8/3.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "BBSResponeCell.h"

@interface BBSResponeCell ()
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UILabel *agressCount;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation BBSResponeCell

- (void)awakeFromNib {
    self.content.preferredMaxLayoutWidth = Swidth - 10 - 10;
}

- (void)setResponse:(TopicResponseInfo *)response {
    _response = response;
    self.content.text  = response.Conten;
    self.name.text = response.UserName;
    self.className.text = response.FromClassName;
    self.agressCount.text = [NSString stringWithFormat:@"%ld",response.Goods];
    self.time.text = response.UpdateTime;
    if (response.IsGood) {
        [self.agreeBtn setImage:[UIImage imageNamed:@"icon_agree_push"] forState:UIControlStateNormal];
    } else {
        [self.agreeBtn setImage:[UIImage imageNamed:@"icon_agree"] forState:UIControlStateNormal];
    }
}
- (IBAction)agreeAction:(id)sender {
    self.agreeBlcok();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
