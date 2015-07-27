//
//  NewMessageCell.m
//  CourseCenter
//
//  Created by 2345 on 15/7/18.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NewMessageCell.h"

@implementation NewMessageCell

- (void)awakeFromNib {
    // Initialization code
    _cell_category.layer.masksToBounds=YES;
    _cell_category.layer.cornerRadius=5;
}
-(void)setIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *array=[_dic objectForKey:[NSString stringWithFormat:@"%d",indexPath.section]];
    if ([array[indexPath.row] isEqualToString:@"SEL"]) {
        _imgBtn.selected=YES;
    }else
    {
        _imgBtn.selected=NO;
    }
}
-(void)setInfo:(NSMutableDictionary *)info
{
    if (_info==nil) {
        _info=info;
        _cell_name.text=[info objectForKey:@"UserName"];
        if ([[info objectForKey:@"Role"] integerValue] ==1) {
        _cell_category.text=@"教师";
        _cell_category.backgroundColor=[UIColor orangeColor];
        }else
        {
        _cell_category.text=@"学生";
        _cell_category.backgroundColor=[UIColor greenColor];
        }
    }
}
- (IBAction)left_btn:(UIButton *)sender {
    sender.selected=!sender.selected;
    if (sender.selected==YES) {
        [((AppDelegate *)app).dicData objectForKey:[NSString stringWithFormat:@"%d",_indexPath.section]][_indexPath.row]=@"ONSEL";
    }else
    {
        [((AppDelegate *)app).dicData objectForKey:[NSString stringWithFormat:@"%d",_indexPath.section]][_indexPath.row]=@"SEL";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
