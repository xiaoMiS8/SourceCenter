//
//  HomeDetailViewController.h
//  CourseCenter
//
//  Created by renxiaojian on 15/5/26.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeDetailViewController : BaseViewController<UIAlertViewDelegate,UIDocumentInteractionControllerDelegate>
@property(nonatomic,assign)long  OCID;
@property(nonatomic,strong)NSString *teacherImgUrl;
@property(nonatomic,strong)NSString *topImgUrl;
@property(nonatomic,assign)int RegStatus;
@end
