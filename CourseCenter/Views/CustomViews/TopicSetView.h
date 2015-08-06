//
//  TopicSetView.h
//  CourseCenter
//
//  Created by rxj on 15/8/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicSetView : UIView

@property(nonatomic, strong) UIView *bgview;
@property(nonatomic, copy) void (^ClickBlock)(NSInteger index);

- (void)show;
- (void)hide;



@end
