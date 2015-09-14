//
//  NewMsgCell1.h
//  CourseCenter
//
//  Created by rxj on 15/9/14.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLTagsControl.h"
@interface NewMsgCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet TLTagsControl *editingTagControl;
@property(nonatomic,strong)NSMutableArray *tags;
@property(nonatomic, strong) NSMutableArray *datas;


@end
