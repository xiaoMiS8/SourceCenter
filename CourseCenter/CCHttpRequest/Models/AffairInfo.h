//
//  AffairInfo.h
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAffairID               @"AffairID"
#define kAffairType             @"AffairType"
#define kAffairDesc             @"AffairDesc"
#define kCreateDate             @"CreateDate"
#define kUserID                 @"UserID"
#define kUserName               @"UserName"
#define kOrganizationName       @"OrganizationName"
#define kClassName              @"ClassName"
#define kReson                  @"Reson"
#define kStatus                 @"Status"

@interface AffairInfo : NSObject

    ///事务ID
@property(nonatomic, assign) long AffairID;
    ///事务类型
@property(nonatomic, strong) NSString *AffairType;
    ///事务详情
@property(nonatomic, strong) NSString *AffairDesc;
    ///创建时间
@property(nonatomic, strong) NSString *CreateDate;
    ///申请人ID
@property(nonatomic, assign) long UserID;
    ///申请人姓名
@property(nonatomic, strong) NSString *UserName;
    ///组织机构名称
@property(nonatomic, strong) NSString *OrganizationName;
    ///班级名称
@property(nonatomic, strong) NSString *ClassName;
    ///原因
@property(nonatomic, strong) NSString *Reson;
    ///状态
@property(nonatomic, assign) int Status;

- (id)initWithDict:(NSDictionary *)dict;

@end
