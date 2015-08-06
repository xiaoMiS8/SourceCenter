//
//  TopicSetView.m
//  CourseCenter
//
//  Created by rxj on 15/8/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "TopicSetView.h"

@interface TopicSetView ()

@property(nonatomic, strong) UIImageView *bgView;
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
    self.bgView= [[UIImageView alloc] initWithFrame:frame];
    self.bgView.backgroundColor = [Tool colorWithHexString:@"#b5b5b5"];
    [self addSubview:self.bgView];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:topView];
    NSArray *imgs = @[@"bbsdis_blue",@"",@"",@""];
    
    for (int i=0; i<4; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor redColor];
        CGFloat width = (Swidth - 10 * 5)/4;
        btn.frame = CGRectMake(10 + i * (width  + 10),5 , width, 50);
        [topView addSubview:btn];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((btn.frame.size.width - 30)/2, 0, 30, 30)];
        img.backgroundColor = [UIColor purpleColor];
        [btn addSubview:img];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(img.frame), btn.frame.size.width, 20)];
        label.font = Font_12;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"设置加精";
        [btn addSubview:label];
    }
    
    
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)hide {
    [self removeFromSuperview];
}

@end
