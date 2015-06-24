//
//  TeacherInfo.h
//  
//
//  Created by jian on 15/6/23.
//
//

#import <Foundation/Foundation.h>

#define kStartDate                  @"StartDate"
#define kTeacherID                  @"TeacherID"
#define kTeacherName                @"TeacherName"
#define kOrganizationName           @"OrganizationName"
#define kRanks                      @"Ranks"
#define kAllPlayDay                 @"AllPlayDay"

@interface TeacherInfo : NSObject

    //开始日期
@property(nonatomic, strong) NSString               *StartDate;
    //教师ID
@property(nonatomic, assign) long                   TeacherID;
    //教师姓名
@property(nonatomic, strong) NSString               *TeacherName;
    //组织机构名称
@property(nonatomic, strong) NSString               *OrganizationName;
    //职称
@property(nonatomic, strong) NSString               *Ranks;
    //总的计划学习天数
@property(nonatomic, assign) long                   AllPlayDay;

- (id)initWithDict:(NSDictionary *)dict;

@end
