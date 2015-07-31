//
//  TestAtion.h
//  CourseCenter
//
//  Created by jian on 15/7/31.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSNetAccessor.h"
#import "TestInfo.h"

#define kReson          @"Reson"

@interface TestAtion : NSObject

+ (void)getAppTestNotSumbitListWithOCID:(long)OCID
                               finished:(FinishedBlock)finished;
+ (void)getAppTestInfoSumbitListWithOCID:(long)OCID
                                finished:(FinishedBlock)finished;
+ (void)addAppOCAffairsWithOCID:(long)OCID
                           Type:(int)Type
                         TestID:(long)TestID
                          Reson:(NSString *)Reson
                       finished:(FinishedBlock)finished;
+ (void)TestCanSeeTestWithTestID:(long)TestID
                        finished:(FinishedBlock)finished;

@end
