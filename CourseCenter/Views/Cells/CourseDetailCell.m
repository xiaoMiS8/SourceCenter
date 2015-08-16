//
//  CourseDetailCell.m
//  CourseCenter
//
//  Created by Mac on 15-6-24.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "CourseDetailCell.h"
@interface CourseDetailCell()
@property (weak, nonatomic) IBOutlet UILabel *fileTitle;
@property (weak, nonatomic) IBOutlet UILabel *TimeLength;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
@implementation CourseDetailCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.layer.borderColor=RGBA(205, 205, 205, 1).CGColor;
    self.contentView.layer.borderWidth=0.5;
    
}
-(void)setMooFileInfo:(MoocFileInfo *)mooFileInfo
{
    [self.fileTitle setText:mooFileInfo.FileTitle];
    [self.TimeLength setText:[Tool timestampToTimeEndSecond:mooFileInfo.TimeLength]];
    if (mooFileInfo.FileType==1) {
        _image.image=[UIImage imageNamed:@"icon_video2"];
    }else if(mooFileInfo.FileType==2)
    {
        _image.image=[UIImage imageNamed:@"word"];
    }else if(mooFileInfo.FileType==3)
    {
        _image.image=[UIImage imageNamed:@"excel"];
    }else if(mooFileInfo.FileType==4)
    {
        _image.image=[UIImage imageNamed:@"ppt"];
    }else if(mooFileInfo.FileType==5)
    {
        _image.image=[UIImage imageNamed:@"pdf"];
    }else if(mooFileInfo.FileType==6)
    {
        _image.image=[UIImage imageNamed:@"icon_photo"];
    }else if(mooFileInfo.FileType==7)
    {
        _image.image=[UIImage imageNamed:@"other"];
    }else if(mooFileInfo.FileType==8)
    {
        _image.image=[UIImage imageNamed:@"icon_document1"];
    }else if(mooFileInfo.FileType==9)
    {
        _image.image=[UIImage imageNamed:@"other"];
    }
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
