//
//  Header.h
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#ifndef CourseCenter_Header_h
#define CourseCenter_Header_h


/** 统一输出日志 */
#ifdef DEBUG //调试阶段
#define DLog(...) NSLog(__VA_ARGS__)
#else       //发布阶段
#define DLog(...)
#endif

    //判断是否为ios7.0
#define IsIOS7 ([[[UIDevice currentDevice] systemVersion] doubleValue] < 7.1 ? YES : NO)
    //判断是否为ios8
#define IsIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0 ? YES : NO)
    //判断是否为iPhone5之后的设备
#define IsIphone5_later ([UIScreen mainScreen].bounds.size.height > 480 ? YES : NO)
    //设备的高
#define SHeight [UIScreen mainScreen].bounds.size.height
#define Swidth [UIScreen mainScreen].bounds.size.width

#endif
