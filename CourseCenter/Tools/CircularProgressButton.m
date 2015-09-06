
#import "CircularProgressButton.h"

@interface CircularProgressButton ()

@property (assign, nonatomic) CGFloat angle;

@end

@implementation CircularProgressButton

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
         UIImage *imgPause = [UIImage imageNamed:@"file_pause_normal.png"];
         UIImage *imgDown =[UIImage imageNamed:@"file_download_normal.png"];
        [self setBackgroundImage:imgPause forState:UIControlStateNormal];
        [self setBackgroundImage:imgDown  forState:UIControlStateSelected];
        _progressColor = progressColor;
        _lineWidth = lineWidth;
        _backColor = backColor;
    }
    return self;
}
- (void)initWithbackColor:(UIColor *)backColor
          progressColor:(UIColor *)progressColor
              lineWidth:(CGFloat)lineWidth
{
    UIImage *imgPause = [UIImage imageNamed:@"file_pause_normal.png"];
    UIImage *imgDown =[UIImage imageNamed:@"file_download_normal.png"];
    [self setBackgroundImage:imgPause forState:UIControlStateNormal];
    [self setBackgroundImage:imgDown  forState:UIControlStateSelected];
    _progressColor = progressColor;
    _lineWidth = lineWidth;
    _backColor = backColor;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
    
    }
    return self;
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    [self setNeedsDisplay];
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateProgressViewWithProgress:)]) {
        [self.delegate updateProgressViewWithProgress:self.progress];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //draw background circle
    UIBezierPath *backCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) radius:(CGRectGetWidth(self.bounds) - self.lineWidth ) / 2 startAngle:(CGFloat) - M_PI_2
        endAngle:(CGFloat)(1.5 * M_PI)  clockwise:YES];
    [self.backColor setStroke];
    backCircle.lineWidth = self.lineWidth;
    [backCircle stroke];
    if (self.progress) {
        //draw progress circle
    UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2,CGRectGetHeight(self.bounds) / 2) radius:(CGRectGetWidth(self.bounds) - self.lineWidth ) / 2 startAngle:(CGFloat) - M_PI_2
        endAngle:(CGFloat)(- M_PI_2 + self.progress * 2 * M_PI) clockwise:YES];
        [self.progressColor setStroke];
        progressCircle.lineWidth = self.lineWidth;
        [progressCircle stroke];
    }
}

@end
