//
//  Tool.m
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "Tool.h"
#import <objc/runtime.h>
@implementation Tool
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
        // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
        // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
        // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
        //r
    NSString *rString = [cString substringWithRange:range];
    
        //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
        //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
        // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *)bgColor
{
    return [self colorWithHexString:@"#eeeff3"];
}

+ (UIColor *)titleBlackColor
{
    return [self colorWithHexString:@"#5a5a61"];
}
+ (UIColor *)titleGrayColor
{
    return [self colorWithHexString:@"#a4a4a4"];
}

+ (NSString *)getToday
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)getNowTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
    //将时间转换为时间戳
+ (NSTimeInterval)timeToTimestamp:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [formatter dateFromString:timeStr];
    NSTimeInterval timesp = [date timeIntervalSince1970];
    formatter = nil;
    return timesp;
}

    //时间戳转换为时间
+ (NSString *)timestampToTime:(NSTimeInterval)timestamp
{
        //    NSString *longOftimesTamp = [NSString stringWithFormat:@"%.0lf", timestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = nil;
        //    if (longOftimesTamp.length > 10) {
    date  = [NSDate dateWithTimeIntervalSince1970:timestamp];
        //    }else{
        //        date  = [NSDate dateWithTimeIntervalSince1970:timestamp];
        //    }
    NSString *timeStr = [formatter stringFromDate:date];
    formatter = nil;
    return timeStr;
}
//时间戳转换为时间(秒表示)
+ (NSString *)timestampToTimeEndSecond:(NSTimeInterval)timestamp
{
    //    NSString *longOftimesTamp = [NSString stringWithFormat:@"%.0lf", timestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm:ss"];
    NSDate *date = nil;
    //    if (longOftimesTamp.length > 10) {
    date  = [NSDate dateWithTimeIntervalSince1970:timestamp];
    //    }else{
    //        date  = [NSDate dateWithTimeIntervalSince1970:timestamp];
    //    }
    NSString *timeStr = [formatter stringFromDate:date];
    formatter = nil;
    return timeStr;
}
+ (NSMutableDictionary *)dictFromObject:(id)object
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [object valueForKey:(NSString *)propertyName];
        if ([propertyValue isKindOfClass:[NSArray class]] || [propertyValue isKindOfClass:[NSMutableArray class]]) {
            propertyValue = [self arrayFormObjectArray:propertyValue];
        }
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
    
}

+ (NSString *)jsonFromArray:(NSArray *)array
{
    NSMutableArray *dics = [[NSMutableArray alloc] initWithCapacity:0];
    for (id object in array) {
        NSDictionary *dic = [self dictFromObject:object];
        [dics addObject:dic];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dics options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
    
}

+ (NSArray *)arrayFormObjectArray:(NSArray *)array
{
    NSMutableArray *dics = [[NSMutableArray alloc] initWithCapacity:0];
    for (id object in array) {
        NSDictionary *dic = [self dictFromObject:object];
        [dics addObject:dic];
    }
    return dics;
}

    //判断字典是否有某key值
+(BOOL)dicContainsKey:(NSDictionary *)dic keyValue:(NSString *)key
{
    
    if ([self objectIsEmpty:dic]) {
        return NO;
    }
    
    NSArray *keyArray = [dic allKeys];
    
    if ([keyArray containsObject:key]) {
        
        return YES;
    }
    return NO;
}

    //判断对象是否为空
+(BOOL)objectIsEmpty:(id)object
{
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (nil == object){
        return YES;
    }
    return NO;
}

+(NSString *)EmptyObjectContainEmptyString:(id)object
{
    if ([self objectIsEmpty:object]) {
        return @"";
    }
    else
    {
        return object;
    }
}

    //判断手机号是否有效
+ (BOOL)isMobileNumber:(NSString *)mobileNum
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


/**
 *	@brief	倒计时按钮获取验证码
 *
 *	@param 	btn 按钮
 */
+(void)startTimeWithBtn:(UIButton *)btn{

    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
            });
        }else{
            // int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime=timeout==60?@"60":[NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                btn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}
+(void)showAlertView:(NSString *)title withMessage:(NSString *)message withTarget:(id)target  withCancel:(NSString *)btn1 other:(NSString *)btn2
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:message delegate:target cancelButtonTitle:btn1 otherButtonTitles:btn2, nil];
    [alert show];
}
//+ (void)saveCookies{
//    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject: cookiesData forKey: @"sessionCookies"];
//    [defaults synchronize];
//    
//}
//+ (void)loadCookies{
//    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
//     NSDictionary *sheaders = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
//    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    
//    for (NSHTTPCookie *cookie in cookies){
//        [cookieStorage setCookie: cookie];
//    }
//}

+(BOOL)isExistWithName:(NSString *)name
{
    NSString *document = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *plistPath = [[document stringByAppendingPathComponent:BASEPATH]stringByAppendingPathComponent:@"finishPlist.plist"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:plistPath]) {
        NSMutableArray *finishArr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
        for (NSDictionary *dic in finishArr) {
            if([name isEqualToString:[dic objectForKey:@"filename"]])
            {
                return YES;
            }
        }
              return NO;
    }
  return NO;
}

+(NSString *)getPathUrlWithName:(NSString *)name
{
    NSString *filePath = [[[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:BASEPATH]stringByAppendingPathComponent:TARGER] stringByAppendingPathComponent:name];
    return filePath;
}
+(NSString *)getHomeDirectory
{
    return NSHomeDirectory();
}
+(NSString *)getAppPath
{
    return [[NSBundle mainBundle]bundlePath];
}
+(NSString *)getDocument
{
  return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)objectAtIndex:0];
}
+(NSString *)getLibrary
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES)objectAtIndex:0];
}
+(NSString *)getTemp
{
    return NSTemporaryDirectory();
}
@end
