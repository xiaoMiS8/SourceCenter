//
//  OCourse.h
//  
//
//  Created by jian on 15/6/19.
//
//

#import <Foundation/Foundation.h>

#define kID                 @"ID"
#define kOCID               @"OCID"
#define kName               @"Name"
#define kTeacherID          @"TeacherID"
#define kTeacherName        @"TeacherName"
#define kUpdateTime         @"UpdateTime"
#define kClicks             @"Clicks"
#define kIsShow             @"IsShow"
#define kLvl                @"Lvl"
#define kOrganizationName   @"OrganizationName"
#define kRanks              @"Ranks"
#define kTeacherImgUrl      @"TeacherImgUrl"
#define kIsNewImg           @"IsNewImg"
#define kCourseImgUrl       @"CourseImgUrl"
#define kRegStatus          @"RegStatus"
#define kStudentCount       @"StudentCount"
#define kRowsCount          @"RowsCount"
#define kTeachingClassName  @"TeachingClassName"
#define kLastStudyChapter   @"LastStudyChapter"
#define kIsShowMooc         @"IsShowMooc"
#define kMyMoocRate         @"MyMoocRate"
#define kPlanMoocRate       @"PlanMoocRate"
#define kIsShowFC           @"IsShowFC"
#define kMyFCRate           @"MyFCRate"
#define kMyGroupFCRate      @"MyGroupFCRate"
#define kPlanFCRate         @"PlanFCRate"

@interface OCourseInfo : NSObject
     //模糊搜索ID
@property(nonatomic, strong) NSNumber* SearchID;
    //id
@property(nonatomic, assign) long ID;
    //在线课程ID
@property(nonatomic, assign) long OCID;
    //课程名称
@property(nonatomic, strong) NSString               *Name;
    //教师ID
@property(nonatomic, assign) long                   TeacherID;
    //教师名称
@property(nonatomic, strong) NSString               *TeacherName;
    //更新时间
@property(nonatomic, strong) NSString               *UpdateTime;
    //点击量
@property(nonatomic, assign) long                   Clicks;
    // 是否展示
@property(nonatomic, assign) BOOL                   IsShow;
    //推荐等级
@property(nonatomic, assign) int                    Lvl;
    //组织机构名称
@property(nonatomic, strong) NSString               *OrganizationName;
    //职称
@property(nonatomic, strong) NSString               *Ranks;
    //用户头像路径
@property(nonatomic, strong) NSString               *TeacherImgUrl;
    //性别
@property(nonatomic, assign) int Gender;
    //1
@property(nonatomic, assign) BOOL                   IsNewImg;
    //课程图片地址
@property(nonatomic, strong) NSString               *CourseImgUrl;
    //能否报名状态(-1未登陆0不能1已报名2未报名)
@property(nonatomic, assign) int                    RegStatus;
    //课程下学生数
@property(nonatomic, assign) int                    StudentCount;
    //列表总数
@property(nonatomic, assign) int                    RowsCount;

    //教学班名称
@property(nonatomic, strong) NSString *TeachingClassName;
    //最后学到第几章第几节
@property(nonatomic, strong) NSString *LastStudyChapter;
    //mooc有无发放章节
@property(nonatomic, assign) BOOL IsShowMooc;
    //我的Mooc进度
@property(nonatomic, strong) NSString *MyMoocRate;
    //标准Mooc进度
@property(nonatomic, strong) NSString *PlanMoocRate;
    //有无翻转课堂
@property(nonatomic, assign) BOOL IsShowFC;
    //我的翻转课堂进度
@property(nonatomic, strong) NSString *MyFCRate;
    //我小组的翻转课堂进度
@property(nonatomic, strong) NSString *MyGroupFCRate;
    // 标准翻转课堂进度
@property(nonatomic, strong) NSString *PlanFCRate;

- (id)initWithDict:(NSDictionary *)dict;

@end
