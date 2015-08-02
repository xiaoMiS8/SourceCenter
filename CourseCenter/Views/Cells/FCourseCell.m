
//
//  FCourseCell.m
//  CourseCenter
//
//  Created by 2345 on 15/8/2.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "FCourseCell.h"

@implementation FCourseCell

- (void)awakeFromNib {
    // Initialization code
    _lable2.backgroundColor=RGBA(29, 169, 127, 1);
    _lable2.layer.masksToBounds=YES;
    _lable2.layer.cornerRadius=5;
    _progress.layer.masksToBounds=YES;
    _progress.layer.cornerRadius=3;
}
-(void)setInfo:(FCourseInfo *)info
{
    if (_info!=info) {
        _info=info;
    }
    if(info.IsEnd==YES)
    {
        _lable2.backgroundColor=[UIColor grayColor];
        _lable2.text=@"已完成";
    }
    _lable1.text=info.Title;
    _lable3.text=[NSString stringWithFormat:@"%d",info.FCStudentCount];
    _lable4.text=[NSString stringWithFormat:@"%d",info.FCLiveGroupCount];
    _lable5.text=info.ClassNames;
    _progress.progress=[info.Progress floatValue]/100;
    _lable6.text=[NSString stringWithFormat:@"%@%@",info.Progress,@"%"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
