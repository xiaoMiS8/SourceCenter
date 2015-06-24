//
//  TeacherInfo.m
//  
//
//  Created by jian on 15/6/23.
//
//

#import "TeacherInfo.h"

@implementation TeacherInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.StartDate = [dict objectForKey:kStartDate];
        self.TeacherID = [[dict objectForKey:kTeacherID] longValue];
        self.TeacherName = [dict objectForKey:kTeacherName];
        self.OrganizationName = [dict objectForKey:kOrganizationName];
        self.Ranks = [dict objectForKey:kRanks];
        self.AllPlayDay = [[dict objectForKey:kAllPlayDay] longValue];
    }
    return self;
}

@end
