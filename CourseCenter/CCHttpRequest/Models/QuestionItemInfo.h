//
//  QuestionItemInfo.h
//  CourseCenter
//
//  Created by jian on 15/8/1.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kQuestionItemID                 @"QuestionItemID"
#define kQuestionID                     @"QuestionID"
#define kConten                         @"Conten"
#define kMaxScore                       @"MaxScore"

@interface QuestionItemInfo : NSObject

    ///选项ID
@property(nonatomic, assign) long QuestionItemID;
    ///题目ID
@property(nonatomic, assign) long QuestionID;
    ///选项内容
@property(nonatomic, strong) NSString *Conten;
    ///分值
@property(nonatomic, assign) int MaxScore;

- (id)initWithDict:(NSDictionary *)dict;

@end
