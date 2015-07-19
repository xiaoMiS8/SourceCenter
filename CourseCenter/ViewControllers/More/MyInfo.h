//
//  MyInfo.h
//  CourseCenter
//
//  Created by 2345 on 15/7/12.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"
#import "UserInfo.h"
@interface MyInfo : BaseViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong,nonatomic)UserInfo *userInfo;
@end
