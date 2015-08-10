//
//  ChapterInfo.h
//  
//
//  Created by jian on 15/6/23.
//
//

#import <Foundation/Foundation.h>

#define kChapterID                      @"ChapterID"
#define kTestID                         @"TestID"
#define kOCID                           @"OCID"
#define kTitle                          @"Title"
#define kParentID                       @"ParentID"
#define kOrde                           @"Orde"
#define kBrief                          @"Brief"
#define kPlanDay                        @"PlanDay"
#define kMinHour                        @"MinHour"
#define kBuildMode                      @"BuildMode"
#define kFileNum                        @"FileNum"
#define kIsFinish                       @"IsFinish"
#define kIsAllowStudy                   @"IsAllowStudy"
#define kIsTest                         @"IsTest"
#define kPopTime                        @"PopTime"

@interface ChapterInfo : NSObject

    //章节ID
@property(nonatomic, assign) long       ChapterID;
    //章节测试ID
@property(nonatomic, assign) long       TestID;
    //在线课程ID
@property(nonatomic, assign) long       OCID;
    //章节名
@property(nonatomic, strong) NSString   *Title;
    //父级ID
@property(nonatomic, assign) long       ParentID;
    //排序
@property(nonatomic, assign) int        Orde;
    //章节简介
@property(nonatomic, strong) NSString   *Brief;
    //计划天数
@property(nonatomic, assign) long       PlanDay;
    //学时
@property(nonatomic, assign) long       MinHour;
    //试卷类型
@property(nonatomic, assign) int        BuildMode;
    //资源数
@property(nonatomic, assign) int        FileNum;
    //是否完成
@property(nonatomic, assign) BOOL       IsFinish;
    // 是否允许学习该节
@property(nonatomic, assign) int       IsAllowStudy;
    //是否为测试
@property(nonatomic, assign) BOOL       IsTest;
    //0
@property(nonatomic, assign) long       PopTime;

- (id)initWithDict:(NSDictionary *)dict;

@end


