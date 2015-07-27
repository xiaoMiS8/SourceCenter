//
//  FCourseInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/27.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCourseInfo : NSObject

    ///翻转课堂ID
@property(nonatomic, assign) long FCID;
    ///标题
@property(nonatomic, strong) NSString *Title;
    ///是否结束
@property(nonatomic, assign) BOOL IsEnd;
    ///开始时间
@property(nonatomic, strong) NSString *StartDate;
    ///学生数
@property(nonatomic, assign) int FCStudentCount;
    ///小组数
@property(nonatomic, assign) int FCLiveGroupCount;
    ///教学班名称
@property(nonatomic, strong) NSString *ClassNames;
    ///总进度
@property(nonatomic, assign) float Progress;

@end
