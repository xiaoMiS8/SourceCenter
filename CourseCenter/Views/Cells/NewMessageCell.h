//
//  NewMessageCell.h
//  CourseCenter
//
//  Created by 2345 on 15/7/18.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NewMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *imgBtn;
@property (weak, nonatomic) IBOutlet UILabel *cell_name;
@property (weak, nonatomic) IBOutlet UILabel *cell_category;
@property (strong,nonatomic)NSIndexPath *indexPath;
@property (nonatomic,assign)NSMutableDictionary  *dic;
@property (nonatomic,strong)NSMutableDictionary *info;
@end
