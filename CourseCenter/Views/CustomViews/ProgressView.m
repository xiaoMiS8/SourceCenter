//
//  ProgressView.m
//  test
//
//  Created by 永利宝 on 15/7/24.
//  Copyright (c) 2015年 RXJ. All rights reserved.
//

#import "ProgressView.h"

#define Width (self.frame.size.width)
#define Height (self.frame.size.height)

@interface ProgressView ()

@property(nonatomic, strong) UIView *progressView;
@property(nonatomic, strong) UIView *line;
@property(nonatomic, strong) UIView *coreView;
@property(nonatomic, strong) UIView *groupProgressView;
@property(nonatomic, strong) UIView *groupLine;
@property(nonatomic, strong) UIView *groupCore;
@property(nonatomic, strong) UIView *normLine;
@property(nonatomic, strong) UIView *normCore;

@end

@implementation ProgressView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initview];
    
}

- (void)setMyProgress:(float)myProgress {
    _myProgress = myProgress;
    CGRect rect = self.progressView.frame;
    rect.size.width = Width *myProgress;
    self.progressView.frame = rect;
    CGRect lineRect = self.line.frame;
    lineRect.origin.x = Width *myProgress -1;
    self.line.frame = lineRect;
    self.coreView.center = CGPointMake(self.line.frame.origin.x + 1, self.line.frame.origin.y);
    
}

- (void)setGroupProgress:(float)groupProgress {
    _groupProgress = groupProgress;
    CGRect rect = self.groupProgressView.frame;
    if (self.myProgress < self.groupProgress) {
        rect.origin.x = CGRectGetMaxX(self.progressView.frame);
        rect.size.width  = groupProgress * Width - self.progressView.frame.size.width;
    } else {
        rect.origin.x = 0;
        rect.size.width  = groupProgress * Width;
    }
    self.groupProgressView.frame = rect;
    CGRect groupRect = self.line.frame;
    groupRect.origin.x = CGRectGetMaxX(self.groupProgressView.frame) - 2;
    self.groupLine.frame = groupRect;
    self.groupCore.center =CGPointMake(self.groupLine.frame.origin.x + 1, self.groupLine.frame.origin.y);
    if (groupProgress == 0) {
        self.groupLine.hidden = YES;
        self.groupCore.hidden = YES;
    }
    
}

- (void)setNormProgress:(float)normProgress {
    _normProgress = normProgress;
    CGRect rect = self.normLine.frame;
    rect.origin.x = normProgress * Width - 1;
    self.normLine.frame = rect;
    CGPoint point = CGPointMake(self.normLine.frame.origin.x + 1, CGRectGetMaxY(self.normLine.frame));
    self.normCore.center = point;
}

- (void)initview {
    UIView *bigview = [[UIView alloc] initWithFrame:CGRectMake(0, 10, Width, Height -10)];
    bigview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    bigview.layer.borderWidth = 0.5;
    bigview.layer.cornerRadius = 2;
    [self addSubview:bigview];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, Height -10)];
    view.backgroundColor = [Tool colorWithHexString:@"#15b591"];
    view.layer.cornerRadius = 2;
    [bigview addSubview:view];
    self.progressView = view;
    
    UIView *line = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.progressView.frame), 0, 2, Height)];
    line.backgroundColor = [Tool colorWithHexString:@"#15b591"];
    [self addSubview:line];
    self.line = line;
    UIView *coreView = [[UIView alloc] init];
    coreView.bounds = CGRectMake(0, 0, 10, 10);
    coreView.backgroundColor = [Tool colorWithHexString:@"#15b591"];
    [self addSubview:coreView];
    coreView.center = self.line.frame.origin;
    coreView.layer.cornerRadius = 5;
    coreView.layer.masksToBounds = YES;
    self.coreView = coreView;
    
    UIView *groupProgressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, Height -10)];
    groupProgressView.backgroundColor = [Tool colorWithHexString:@"#3e4967"];
    [self.progressView addSubview:groupProgressView];
    self.groupProgressView = groupProgressView;
    
    UIView *groupLine = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.groupProgressView.frame), 0, 2, Height)];
    groupLine.backgroundColor = [Tool colorWithHexString:@"#3e4967"];
    [self addSubview:groupLine];
    self.groupLine = groupLine;
    
    UIView *groupCore = [[UIView alloc] init];
    groupCore.bounds = CGRectMake(0, 0, 10, 10);
    groupCore.backgroundColor = [Tool colorWithHexString:@"#3e4967"];
    [self addSubview:groupCore];
    groupCore.center = self.line.frame.origin;
    groupCore.layer.cornerRadius = 5;
    groupCore.layer.masksToBounds = YES;
    self.groupCore = groupCore;
    
    UIView *normline = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 2, Height)];
    normline.backgroundColor = [Tool colorWithHexString:@"#f37385"];
    [self addSubview:normline];
    self.normLine = normline;
    
    UIView *normCore = [[UIView alloc] init];
    normCore.bounds = CGRectMake(0, 0, 10, 10);
    CGPoint point = CGPointMake(self.normLine.frame.origin.x, CGRectGetMaxY(self.normLine.frame));
    normCore.center = point;
    normCore.backgroundColor = [Tool colorWithHexString:@"#f37385"];
    normCore.layer.cornerRadius = 5;
    normCore.layer.masksToBounds = YES;
    [self addSubview:normCore];
    self.normCore = normCore;

    
}

@end
