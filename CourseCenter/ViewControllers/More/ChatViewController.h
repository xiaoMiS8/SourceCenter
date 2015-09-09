//
//  ChatViewController.h
//  CourseCenter
//
//  Created by 2345 on 15/7/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
@property (nonatomic,assign)long userID;
@property (nonatomic,strong)NSString *MessageID;
@end
