//
//  MyPicViewController.h
//  CourseCenter
//
//  Created by 2345 on 15/9/3.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"

@interface MyPicViewController : BaseViewController
@property(nonatomic,strong)NSString *picName;
@property(nonatomic,strong)NSString *path;
@property(nonatomic,strong)NSString *url;
@property(nonatomic,assign)BOOL isNSBundle;
@end
