//
//  SubjectSearchViewController.h
//  CourseCenter
//
//  Created by 2345 on 15/6/30.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"

@interface SubjectSearchViewController : BaseViewController<UISearchBarDelegate>
@property(nonatomic,assign)long SpecialtyTypeID;
@property (nonatomic,retain) NSMutableDictionary *contactDic;
@property (nonatomic,retain) NSMutableArray *searchByName;
@property (nonatomic,retain) NSMutableArray *searchByPhone;
@end
