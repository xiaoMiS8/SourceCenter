//
//  TPViewController.h
//  CourseCenter
//
//  Created by jian on 15/7/25.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "CourseBaseViewController.h"

@interface TPViewController : CourseBaseViewController

@property(nonatomic, strong) UIButton *rightBtn;
@property(nonatomic,assign)long OCID;
-(void)LoadData;
@end
