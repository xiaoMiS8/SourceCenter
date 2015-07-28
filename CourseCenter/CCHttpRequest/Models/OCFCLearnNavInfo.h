//
//  OCFCLearnNavInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RankInfo.h"

#define kOCFCFileList           @"OCFCFileList"
#define kOCFCTestList           @"OCFCTestList"
#define kOCFCForumTopicList     @"OCFCForumTopicList"
#define kFCOfflineList          @"FCOfflineList"
#define kOCFCSurveyList         @"OCFCSurveyList"
#define kOcFcScore              @"OcFcScore"

@interface OCFCLearnNavInfo : NSObject

    ///学习资料
@property(nonatomic, strong) NSArray *OCFCFileList;
    ///作业测试
@property(nonatomic, strong) NSArray *OCFCTestList;
    ///论题互动
@property(nonatomic, strong) NSArray *OCFCForumTopicList;
    ///线下课堂
@property(nonatomic, strong) NSArray *FCOfflineList;
    ///互相评价
@property(nonatomic, strong) NSArray *OCFCSurveyList;
    ///我的得分
@property(nonatomic, strong) RankInfo *OcFcScore;

- (id)initWithDict:(NSDictionary *)dict;

@end
