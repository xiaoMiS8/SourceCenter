//
//  NewMsgCell1.m
//  CourseCenter
//
//  Created by rxj on 15/9/14.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NewMsgCell1.h"

@implementation NewMsgCell1


- (void)awakeFromNib {
 
}



- (void)setDatas:(NSMutableArray *)datas {
    _datas = datas;
    _editingTagControl.tags = [_tags mutableCopy];
    _editingTagControl.data= datas;
    _editingTagControl.tagPlaceholder=@"";
    [_editingTagControl reloadTagSubviews];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
