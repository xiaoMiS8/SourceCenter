//
//  FCourseDetailOne.m
//  CourseCenter
//
//  Created by muzhenhua on 15/8/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "FCourseDetailOne.h"

@implementation FCourseDetailOne

- (void)awakeFromNib {
    // Initialization code
    _progress.layer.masksToBounds=YES;
    _progress.layer.cornerRadius=3;
}
-(void)setCgInfo:(CGroupInfo *)cgInfo
{
    if (_cgInfo!=cgInfo) {
        _cgInfo=cgInfo;
        _groupName.text=_cgInfo.Name;
        _groupRank.text=[NSString stringWithFormat:@"%@(一共%d组)",_cgInfo.RanKInfo,_cgInfo.GroupCount];
        _progress.progress=_cgInfo.GroupProgress/100;
        _progressNumber.text=[NSString stringWithFormat:@"%.1f%@",_cgInfo.GroupProgress,@"%"];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
