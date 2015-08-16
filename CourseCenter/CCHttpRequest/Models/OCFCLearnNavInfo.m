//
//  OCFCLearnNavInfo.m
//  CourseCenter
//
//  Created by muzhenhua on 15/8/3.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "OCFCLearnNavInfo.h"
#import "OCFCFileInfo.h"
#import "SourceInfo.h"
#import "FCOfflineInfo.h"
#import "RankInfo.h"

@implementation OCFCLearnNavInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        NSArray *OCFCFileList = dict[kOCFCFileList];
        if (OCFCFileList) {
            NSMutableArray *OCFCFiles = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i=0; i<OCFCFileList.count; i++) {
                OCFCFileInfo *ocfcFile = [[OCFCFileInfo alloc] initWithDict:OCFCFileList[i]];
                [OCFCFiles addObject:ocfcFile];
            }
            self.OCFCFileList = OCFCFiles;
        }
        NSArray *OCFCTestList = dict[kOCFCTestList];
        if (OCFCTestList) {
            NSMutableArray *OCFCTests = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i=0; i<OCFCTestList.count; i++) {
                SourceInfo *source = [[SourceInfo alloc] initWithdict:OCFCTestList[i]];
                [OCFCTests addObject:source];
            }
            self.OCFCTestList = OCFCTests;
        }
        NSArray *OCFCForumTopicList = dict[kOCFCForumTopicList];
        if (OCFCForumTopicList) {
            NSMutableArray *OCFCForumTopics = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i=0; i<OCFCForumTopicList.count; i++) {
                SourceInfo *source = [[SourceInfo alloc] initWithdict:OCFCForumTopicList[i]];
                [OCFCForumTopics addObject:source];
            }
            self.OCFCForumTopicList = OCFCForumTopics;
        }
        NSArray *FCOfflineList = dict[kFCOfflineList];
        if (FCOfflineList) {
            NSMutableArray *FCOfflines = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i=0; i<FCOfflineList.count; i++) {
                FCOfflineInfo *fcoffline = [[FCOfflineInfo alloc] initWithDict:FCOfflineList[i]];
                [FCOfflines addObject:fcoffline];
            }
            self.FCOfflineList = FCOfflines;
        }
        NSArray *OCFCSurveyList = dict[kOCFCSurveyList];
        if (OCFCSurveyList) {
            NSMutableArray *OCFCSurveys = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i=0; i<OCFCSurveyList.count; i++) {
                SourceInfo *source = [[SourceInfo alloc] initWithdict:OCFCSurveyList[i]];
                [OCFCSurveys addObject:source];
            }
            self.OCFCSurveyList = OCFCSurveys;
        }
        self.OcFcScore = [[RankInfo alloc] initWithDict:dict[kOcFcScore]];
        
    }
    return self;
}

@end
