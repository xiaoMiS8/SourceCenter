//
//  Tool.h
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

#pragma mark- 时间处理

    //获取今天日期
+ (NSString *)getToday;
    //获取现在的时间
+ (NSString *)getNowTime;
    //将时间转换为时间戳
+ (NSTimeInterval)timeToTimestamp:(NSString *)timeStr;
    //时间戳转换为时间
+ (NSString *)timestampToTime:(NSTimeInterval)timestamp;

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

@end
