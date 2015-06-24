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

@interface OCourse : NSObject

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

- (id)initWithDict:(NSDictionary *)dict;

@end
