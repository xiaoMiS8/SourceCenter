//
//  Tool.h
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

#pragma mark- 颜色

    //十六进制颜色转化为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;
    //背景色
+ (UIColor *)bgColor;
    //黑色字体
+ (UIColor *)titleBlackColor;
    //灰色字体
+ (UIColor *)titleGrayColor;

#pragma mark- 时间处理

    //获取今天日期
+ (NSString *)getToday;
    //获取现在的时间
+ (NSString *)getNowTime;
    //将时间转换为时间戳
+ (NSTimeInterval)timeToTimestamp:(NSString *)timeStr;
    //时间戳转换为时间
+ (NSString *)timestampToTime:(NSTimeInterval)timestamp;
//时间戳转换为时间(分钟表示)
+ (NSString *)timestampToTimeEndSecond:(NSTimeInterval)timestamp;
#pragma mark- 对象处理

    //将对象装换为dic
+ (NSMutableDictionary *)dictFromObject:(id)object;
    //将一个数组转换为json格式
+ (NSString *)jsonFromArray:(NSArray *)array;
    //将一个数组里的对象转换为字典
+ (NSArray *)arrayFormObjectArray:(NSArray *)array;
    //判断字典是否有某key值
+(BOOL)dicContainsKey:(NSDictionary *)dic keyValue:(NSString *)key;
    //判断对象是否为空
+(BOOL)objectIsEmpty:(id)object;
    //把空的的字符串转换为@“”
+(NSString *)EmptyObjectContainEmptyString:(id)object;
    //判断手机号是否有效
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
#pragma mark- 按钮处理
+(void)startTimeWithBtn:(UIButton *)btn;
#pragma mark- alertView
+(void)showAlertView:(NSString *)title withMessage:(NSString *)message withTarget:(id)target  withCancel:(NSString *)btn1 other:(NSString *)btn2;
#pragma mark- Cookies处理
//+ (void)saveCookies;
//+ (void)loadCookies;
#pragma mark- 下载资料文件处理
+(BOOL)isExistWithName:(NSString *)name;
+(NSString *)getPathUrlWithName:(NSString *)name;
#pragma mark- 沙河目录
+(NSString *)getHomeDirectory;
+(NSString *)getAppPath;
+(NSString *)getDocument;
+(NSString *)getLibrary;
+(NSString *)getTemp;
@end
