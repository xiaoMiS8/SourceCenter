//
//  SelectClassViewController.h
//  CourseCenter
//
//  Created by 任晓健 on 15/8/19.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectClassViewController : BaseViewController

@property(nonatomic, assign) long OCID;
@property(nonatomic, copy) void (^selectedBlcok)(OCClassInfo *ocClass);

@end
