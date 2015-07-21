//
//  NewNotimgCell.m
//  CourseCenter
//
//  Created by jian on 15/7/19.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "NewNotimgCell.h"


@implementation NewNotimgCell

- (void)awakeFromNib {
    self.oneBtn.layer.cornerRadius = 4;
    self.twoBtn.layer.cornerRadius = 4;
    self.threeBtn.layer.cornerRadius = 4;
}

- (void)setImgs:(NSArray *)imgs {
    _imgs = imgs;
    if (imgs) {
        if (imgs.count == 1) {
            self.oneImage.image = imgs[0];
            self.oneBtn.hidden = NO;
            self.twoBtn.hidden = YES;
            self.threeBtn.hidden = YES;
            self.twoImage.image = nil;
            self.threeImage.image = nil;
        } else if (imgs.count == 2) {
            self.oneImage.image = imgs[0];
            self.twoImage.image =  imgs[1];
            self.threeImage.image = nil;
            self.oneBtn.hidden = NO;
            self.twoBtn.hidden = NO;
            self.threeBtn.hidden = YES;
        } else if(imgs.count == 3) {
            self.oneImage.image = imgs[0];
            self.twoImage.image =  imgs[1];
            self.threeImage.image =  imgs[2];
            self.oneBtn.hidden = NO;
            self.twoBtn.hidden = NO;
            self.threeBtn.hidden = NO;
        } else {
            self.oneBtn.hidden = YES;
            self.twoBtn.hidden = YES;
            self.threeBtn.hidden = YES;
             self.oneImage.image = nil;
            self.twoImage.image = nil;
            self.threeImage.image = nil;
        }
        
        
    }


}
- (IBAction)btnAction:(id)sender {
    self.deleteBlock((UIButton *)sender);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
