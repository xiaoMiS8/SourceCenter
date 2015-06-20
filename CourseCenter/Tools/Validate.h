//
//  Validate.h
//  CourseCenter
//
//  Created by muzhenhua on 14-11-5.
//  Copyright (c) 2014年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    validateUserName = 0,    //用户名认证
    validatePassword=1,      //密码认证
    validatePasswordIsSame=2,//密码是否一致认证
    validateMobile = 3,      //手机号认证
    validateEmail = 4,       //邮箱认证
    validateHanzi=5,         //汉字认证
    validateIdentityCard=6,  //身份证号认证
    validateNull =7,         //是否为空认证
    volatileBankId           //银行卡号认证
}validateType;
@interface Validate : NSObject
+ (BOOL) validateUserName:(NSString *)name;
+ (BOOL) validatePassword:(NSString *)passWord;
+ (BOOL) validatePassIsSame:(NSString *)twopass;
+ (BOOL) validateMobile:(NSString *)mobileNum;
+ (BOOL) validateEmail:(NSString *)email;
+ (BOOL) validateHanzi:(NSString *)hanzi;
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
+ (BOOL) validateNull:(NSString *)string;
+ (BOOL) validataWithParams:(NSDictionary *)params withTarget:(id)target;
@end
