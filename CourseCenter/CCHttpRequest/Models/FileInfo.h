//
//  FileInfo.h
//  CourseCenter
//
//  Created by 永利宝 on 15/7/16.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileInfo : NSObject

    //全部资料
@property(nonatomic, assign) int AllCount;
    //文稿资料
@property(nonatomic, assign) int ElseCount;
    // 图片资料
@property(nonatomic, assign) int PicCount;
    //视频资料
@property(nonatomic, assign) int VideoCount;

@end
