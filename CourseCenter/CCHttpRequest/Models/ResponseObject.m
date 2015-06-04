//
//  ResponseObject.m
//  ZeroManage
//
//  Created by jian on 14/12/10.
//  Copyright (c) 2014年 line0.com. All rights reserved.
//

#import "ResponseObject.h"

@implementation ResponseObject

-(id)init {
    if (self == [super init]) {
        self.resultArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.errrorCode = [dict objectForKey:KerrorCode];
        self.errorMessage = [dict objectForKey:KerrorMessage];
        self.resultArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"Status:%d \n Errorcode:%@ \n message:%@\n Object:%@\n resultObject:%@\n",self.status,self.errrorCode,self.message,self.resultArray,self.resultObject];
}

@end
