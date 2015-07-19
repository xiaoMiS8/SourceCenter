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
    
}

- (void)setImgs:(NSArray *)imgs {
    _imgs = imgs;
    if (imgs) {
        if (imgs.count == 1) {
            self.oneImage.image = imgs[0];
        } else if (imgs.count == 2) {
            self.oneImage.image = imgs[0];
            self.twoImage.image =  imgs[1];
        } else if(imgs.count == 3) {
            self.oneImage.image = imgs[0];
            self.twoImage.image =  imgs[1];
            self.threeImage.image =  imgs[2];
        }
        
        
    }


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
