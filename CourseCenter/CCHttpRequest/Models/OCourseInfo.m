//
//  OCourse.m
//  
//
//  Created by jian on 15/6/19.
//
//

#import "OCourseInfo.h"

@implementation OCourseInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.ID = [[dict objectForKey:kID] longValue];
        self.OCID = [[dict objectForKey:kOCID] longValue];
        self.Name = [dict objectForKey:kName];
        self.TeacherID = [[dict objectForKey:kTeacherID] longValue];
        self.TeacherName = [dict objectForKey:kTeacherName];
        self.UpdateTime = [dict objectForKey:kUpdateTime];
        self.Clicks = [[dict objectForKey:kClicks] longValue];
        self.IsShow = [[dict objectForKey:kIsShow] boolValue];
        self.Lvl = [[dict objectForKey:kLvl] intValue];
        self.OrganizationName = [dict objectForKey:kOrganizationName];
        self.Ranks = [dict objectForKey:kRanks];
        self.TeacherImgUrl = [dict objectForKey:kTeacherImgUrl];
        self.IsNewImg = [[dict objectForKey:kIsNewImg] boolValue];
        self.CourseImgUrl = [dict objectForKey:kCourseImgUrl];
        self.RegStatus = [[dict objectForKey:kRegStatus] intValue];
        self.StudentCount = [[dict objectForKey:kStudentCount] intValue];
        self.RowsCount = [[dict objectForKey:kRowsCount] intValue];
        self.TeachingClassName = [dict objectForKey:kTeachingClassName];
        self.LastStudyChapter = [dict objectForKey:kLastStudyChapter];
        self.IsShowMooc = [[dict objectForKey:kIsShowMooc] boolValue];
        self.MyMoocRate = [dict objectForKey:kMyMoocRate];
        self.PlanMoocRate = [dict objectForKey:kPlanMoocRate];
        self.IsShowFC = [[dict objectForKey:kIsShowFC] boolValue];
        self.MyFCRate = [dict objectForKey:kMyFCRate];
        self.MyGroupFCRate = [dict objectForKey:kMyGroupFCRate];
        self.PlanFCRate = [dict objectForKey:kPlanFCRate];
        self.Gender = [dict[KGender] intValue];
    }
    return self;
}

@end
