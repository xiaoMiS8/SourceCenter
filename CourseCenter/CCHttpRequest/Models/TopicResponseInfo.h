//
//  TopicResponseInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/29.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kResponseID             @"ResponseID"
#define kParentID               @"ParentID"
#define kConten                 @"Conten"
#define kUserName               @"UserName"
#define kFromClassName          @"FromClassName"
#define kUpdateTime             @"UpdateTime"
#define kIsTop                  @"IsTop"
#define kIsGood                 @"IsGood"
#define kGoods                  @"Goods"

@interface TopicResponseInfo : NSObject

    ///回复ID
@property(nonatomic, assign) long ResponseID;
    ///父级ID
@property(nonatomic, assign) long ParentID;
    ///内容
@property(nonatomic, strong) NSString *Conten;
    ///回复人名称
@property(nonatomic, strong) NSString *UserName;
    ///班级名称
@property(nonatomic, strong) NSString *FromClassName;
    ///回复时间
@property(nonatomic, strong) NSString *UpdateTime;
    ///是否置顶
@property(nonatomic, assign) BOOL IsTop;
    ///我是否点赞
@property(nonatomic, assign) BOOL IsGood;
    ///点赞数
@property(nonatomic, assign) long Goods;

- (id)initWithDict:(NSDictionary *)dict;

@end
