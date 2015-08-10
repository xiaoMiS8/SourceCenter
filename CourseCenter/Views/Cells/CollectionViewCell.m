//
//  CollectionViewCell.m
//  CourseCenter
//
//  Created by 2345 on 15/8/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    _imageView.layer.masksToBounds=YES;
    _imageView.layer.cornerRadius=3;
    _type.layer.masksToBounds=YES;
    _type.layer.cornerRadius=3;
}
-(void)setInfo:(UserInfo *)info
{
    if (_info!=info) {
        _info=info;
    }
    if (_info.IsStudent) {
        _type.text=@"学";
        _type.backgroundColor=RGBA(20, 157, 236, 1);
    }else{
        _type.text=@"教";
        _type.backgroundColor=RGBA(253, 132, 136, 1);
    }
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_info.userImg] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
    _name.text=[NSString stringWithFormat:@"%@ %.f%@",_info.userName,_info.Progress,@"%"];
}
@end
