//
//  ResponseObject.h
//  ZeroManage
//
//  Created by jian on 14/12/10.
//  Copyright (c) 2014年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KerrorCode                  @"errorCode"
#define KerrorMessage               @"errorMessage"

@interface ResponseObject : NSObject

    ///提示语
@property(nonatomic, strong) NSString       *message;
    ///错误代码
@property(nonatomic, strong) NSString       *errrorCode;
    ///状态
@property(nonatomic, assign) int            status;
    ///返回单个对象
@property(nonatomic, strong) id             resultObject;
    ///返回数组
@property(nonatomic, strong) NSMutableArray *resultArray;

@property(nonatomic, strong) NSString *errorMessage;

- (id)initWithDict:(NSDictionary *)dict;

@end
