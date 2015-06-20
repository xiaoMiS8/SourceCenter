//
//  Validate.m
//  CourseCenter
//
//  Created by muzhenhua on 14-11-5.
//  Copyright (c) 2014年 line0.com. All rights reserved.
//

#import "Validate.h"
#import "NSString+HandleString.h"
#import "MBProgressHUD.h"
@interface Validate()
{
    MBProgressHUD *hud;
}
@end
@implementation Validate

//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    //5-12位以字母数字开头的用户名
    NSString *userNameRegex = @"^[a-zA-Z0-9]{5,12}$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;

}

//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    if (passWord.length>=6&&passWord.length<=30) {
        return YES;
    }else
    {
        return NO;
    }
}

//密码是否一致
+(BOOL)validatePassIsSame:(NSString *)twopass

{
    NSString *pass1=[twopass carveNSStringWithStr:@" "][0];
    NSString *pass2=[twopass carveNSStringWithStr:@" "][1];
    if ([pass1 isEqualToString:pass2]) {
        return YES;
    }
    return NO;
}

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//汉字
+(BOOL) validateHanzi:(NSString *)hanzi
{
    NSString *regex=@"^[\u4E00-\u9FA5]*$";
    NSPredicate *hanziPredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [hanziPredicate evaluateWithObject:hanzi];
    
}

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//空值
+(BOOL) validateNull:(NSString *)string
{
    if ([string isEqualToString:@""]) {
        return NO;
    }
    return YES;
}
//银行卡
+(BOOL)validateBankId:(NSString *)bankid
{
    if(bankid.length>=16 &&bankid.length<=19)
    {
        return YES;
    }
    return NO;
}
+(BOOL)validataWithParams:(NSDictionary *)params withTarget:(id)target
{
    NSArray *allkeys=[params allKeys];
    NSArray *compAllkeys=[allkeys sortedArrayUsingComparator:cmptr];
    for (int i=0; i<[params count]; i++) {
        NSString *key=[compAllkeys objectAtIndex:i];
        id value=[params objectForKey:key];
        switch ([key integerValue]) {
            case validateEmail:
                if (![self validateEmail:value]) {
                    return NO;
                } ;
            case validateMobile:
                if (![self validateMobile:value]) {
                    return NO;
                } ;
            case validateUserName:
                if (![self validateUserName:value]) {
                    return NO;
                } ;
            case validatePassword:
                if (![self validatePassword:value]) {
                    return NO;
                } ;
            case validateIdentityCard:
                if (![self validateIdentityCard:value]) {
                    return NO;
                } ;
            case validateHanzi:
                if (![self validateHanzi:value]) {
                    return NO;
                } ;
            case validateNull:
                if (![self validateNull:value]) {
                    return NO;
                } ;
            case volatileBankId:
                if (![self validateBankId:value]) {
                    return NO;
                } ;
            case validatePasswordIsSame:
                if (![self validatePassIsSame:value]) {
                    return NO;
                } ;
            default:
                if (![self validateNull:value]) {
                    return NO;
                } ;
        }
    }
    return YES;
}
//数组排序
NSComparator cmptr = ^(id obj1, id obj2){
    if ([obj1 integerValue] > [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    
    if ([obj1 integerValue] < [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
};
@end