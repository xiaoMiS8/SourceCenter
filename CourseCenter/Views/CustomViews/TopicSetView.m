//
//  TopicSetView.m
//  CourseCenter
//
//  Created by rxj on 15/8/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "TopicSetView.h"

@interface TopicSetView ()

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIView *topview;

@end

@implementation TopicSetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self initview];
    }
    return self;
}

- (void)initview {
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.bgView= [[UIView alloc] initWithFrame:frame];
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.5;
    [self addSubview:self.bgView];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
    [self.bgView addSubview:topView];
    
    
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)hide {
    [self removeFromSuperview];
}

@end
