//
//  TopicInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/29.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kTopicID                @"TopicID"
#define kIsEssence              @"IsEssence"
#define kIsTop                  @"IsTop"
#define kTitle                  @"Title"
#define kConten                 @"Conten"
#define kUserName               @"UserName"
#define kIsTeacherTopic         @"IsTeacherTopic"
#define kForumClassName         @"FromClassName"
#define kUpdateTime             @"UpdateTime"
#define kClicks                 @"Clicks"
#define kResponses              @"Responses"
#define kGoods                  @"Goods"
#define kIsGood                 @"IsGood"
#define kRowsCount              @"RowsCount"
#define kIsCanDel               @"IsCanDel"
#define kimgs                   @"ImgUrl"

@interface TopicInfo : NSObject

    ///帖子ID
@property(nonatomic, assign) long           TopicID;
    ///是否精华
@property(nonatomic, assign) BOOL           IsEssence;
    ///是否置顶
@property(nonatomic, assign) BOOL           IsTop;
    ///标题
@property(nonatomic, strong) NSString       *Title;
    ///内容
@property(nonatomic, strong) NSString       *Conten;
    ///发帖人姓名
@property(nonatomic, strong) NSString       *UserName;
    ///是否教师发帖
@property(nonatomic, assign) BOOL           IsTeacherTopic;
    ///帖子班级名称
@property(nonatomic, strong) NSString       *ForumClassName;
    ///更新时间
@property(nonatomic, strong) NSString       *UpdateTime;
    ///点击量
@property(nonatomic, assign) long           Clicks;
    ///回复数
@property(nonatomic, assign) long           Responses;
    ///点赞数
@property(nonatomic, assign) long           Goods;
    ///我是否点赞
@property(nonatomic, assign) BOOL           IsGood;
    ///列表总数
@property(nonatomic, assign) long           RowsCount;
    ///图片（接口暂时没有该字段）
@property(nonatomic, strong) NSArray *imgs;
@property(nonatomic, assign) BOOL iscanDel;
@property(nonatomic, strong) NSString *userImg;
@property(nonatomic, assign) int Gender;

- (id)initWithDict:(NSDictionary *)dict;

@end
