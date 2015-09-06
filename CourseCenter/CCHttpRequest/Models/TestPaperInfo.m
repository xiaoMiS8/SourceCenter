//
//  TestPaperInfo.m
//  CourseCenter
//
//  Created by rxj on 15/7/31.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "TestPaperInfo.h"

@implementation TestPaperInfo

- (id)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.paper = [[PaperInfo alloc] initWithDict:dict[kpaper]];
        NSArray *array = dict[kpapergrouplist];
        NSMutableArray *papergrouplist = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i=0; i<array.count; i++) {
            PaperGroupInfo *papaergroup = [[PaperGroupInfo alloc] initWithDict:array[i]];
            [papergrouplist addObject:papaergroup];
        }
        self.papergrouplist = papergrouplist;
        NSArray *exercises = dict[kexerciselist];
        NSMutableArray *exerciselist = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i=0; i<exercises.count; i++) {
            ExerciseInfo *exercise = [[ExerciseInfo alloc] initWithDict:exercises[i]];
            [exerciselist addObject:exercise];
        }
        self.exerciselist = exerciselist;
        NSArray *ExerciseAttachments = dict[kExerciseAttachmentlist];
        NSMutableArray *ExerciseAttachmentlist = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i=0; i<ExerciseAttachments.count; i++) {
            AttachmentInfo *attachment = [[AttachmentInfo alloc] initWithDict:ExerciseAttachments[i]];
            [ExerciseAttachmentlist addObject:attachment];
        }
        self.ExerciseAttachmentlist = ExerciseAttachmentlist;
    }
    return self;
}

@end
