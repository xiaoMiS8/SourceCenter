//
//  TestPaperInfo.h
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaperInfo.h"
#import "PaperGroupInfo.h"
#import "ExerciseInfo.h"
#import "AttachmentInfo.h"

#define kpaper                      @"paper"
#define kpapergrouplist             @"papergrouplist"
#define kattachmentlist             @"attachmentlist"
#define kexerciselist               @"exerciselist"
#define kExerciseAttachmentlist     @"ExerciseAttachmentlist"

@interface TestPaperInfo : NSObject

@property(nonatomic, strong) PaperInfo *paper;
    ///试卷的分组
@property(nonatomic, strong) NSArray *papergrouplist;
    ///分组下的附件
@property(nonatomic, strong) NSArray *attachmentlist;
    ///分组下的习题
@property(nonatomic, strong) NSArray *exerciselist;
    ///习题下的附件列表
@property(nonatomic, strong) NSArray *ExerciseAttachmentlist;

- (id)initWithDict:(NSDictionary *)dict;

@end
