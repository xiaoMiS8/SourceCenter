//
//  PICircularProgressView.h
//  QiyiDai
//
//  Created by muzhenhua on 14-11-4.
//  Copyright (c) 2014年 leichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PICircularProgressView : UIView

@property (nonatomic) double progress;

// Should be BOOLs, but iOS doesn't allow BOOL as UI_APPEARANCE_SELECTOR
@property (nonatomic) NSInteger showText UI_APPEARANCE_SELECTOR;
@property (nonatomic) NSInteger roundedHead UI_APPEARANCE_SELECTOR;
@property (nonatomic) NSInteger showShadow UI_APPEARANCE_SELECTOR;

@property (nonatomic) CGFloat thicknessRatio UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *innerBackgroundColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *outerBackgroundColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *font UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *progressFillColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *progressTopGradientColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *progressBottomGradientColor UI_APPEARANCE_SELECTOR;

@end
