//
//  GroupInfoViewController.h
//  CourseCenter
//
//  Created by 2345 on 15/8/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "CourseBaseViewController.h"

@interface GroupInfoViewController : CourseBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,assign)long OCID;
@property (nonatomic,assign)long FCID;
@end
