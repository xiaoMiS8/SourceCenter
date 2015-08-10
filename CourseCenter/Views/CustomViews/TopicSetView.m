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
@property(nonatomic, assign) int count;

@end

@implementation TopicSetView

- (id)initWithFrame:(CGRect)frame andCount:(int)count
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.count = count;
        self.backgroundColor = [UIColor whiteColor];
        [self initview];
    }
    return self;
}

- (void)initview {
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.bgView= [[UIImageView alloc] initWithFrame:frame];
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.bgView addGestureRecognizer:tap];
    [self addSubview:self.bgView];
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:topView];
    NSArray *imgs = @[@"bbsdis_red",@"bbsdis_blue",@"bbsdis_green",@"bbsdis_gray"];
    NSArray *titles = @[@"设为置顶",@"设为加精",@"分享",@"删除该贴"];
    
    for (int i=0; i<4; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+1;
        CGFloat width = (Swidth - 10 * 5)/4;
        btn.frame = CGRectMake(10 + i * (width  + 10),5 , width, 50);
        [topView addSubview:btn];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((btn.frame.size.width - 30)/2, 0, 30, 30)];
        img.image = [UIImage imageNamed:imgs[i]];
        [btn addSubview:img];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(img.frame), btn.frame.size.width, 20)];
        label.font = Font_12;
        label.textAlignment = NSTextAlignmentCenter;
        label.text = titles[i];
        [btn addSubview:label];
    }
    
    
}

- (void)setBgview:(UIView *)bgview {
    _bgview = bgview;
    UIImage *image = [self getImageFromView:bgview];
    image = [self getBlurImageWithImg:image];
    self.bgView.image = image;
}

-(UIImage *)getImageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContextWithOptions(theView.frame.size, YES, theView.layer.contentsScale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)getBlurImageWithImg:(UIImage *)img {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *image = [CIImage imageWithCGImage:img.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@3.0f forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:[result extent]];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    return blurImage;
}

- (void)btnAction:(UIButton *)btn {
    self.ClickBlock(btn.tag);
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self];
}

- (void)hide {
    [self removeFromSuperview];
}

@end
