//
//  SpecialtyTypeInfo.m
//  
//
//  Created by jian on 15/6/19.
//
//

#import "SpecialtyTypeInfo.h"

@implementation SpecialtyTypeInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.SpecialtyTypeID = [[dict objectForKey:kSpecialtyTypeID] longValue];
        self.SpecialtyTypeNo = [dict objectForKey:kSpecialtyTypeNo];
        self.SpecialtyTypeName = [dict objectForKey:kSpecialtyTypeName];
        self.ParentID = [[dict objectForKey:kParentID] longValue];
    }
    return self;
}

@end
