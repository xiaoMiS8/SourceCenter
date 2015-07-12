//
//  MyInfoCell.h
//  CourseCenter
//
//  Created by 2345 on 15/7/12.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLable;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong,nonatomic)NSIndexPath *indexPath;
@property (weak, nonatomic) IBOutlet UILabel *line;
@end
