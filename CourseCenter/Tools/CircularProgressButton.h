
#import <UIKit/UIKit.h>

@protocol CircularProgressButtonDelegate <NSObject>

@optional

- (void)updateProgressViewWithProgress:(float)progress;

@end

@interface CircularProgressButton : UIButton
@property (nonatomic) float progress;
@property (nonatomic) UIColor *backColor;
@property (nonatomic) UIColor *progressColor;
@property (assign, nonatomic) CGFloat lineWidth;
@property (assign, nonatomic) id <CircularProgressButtonDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth;
- (void)initWithbackColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth;
- (void)setProgress:(float)progress;
@end