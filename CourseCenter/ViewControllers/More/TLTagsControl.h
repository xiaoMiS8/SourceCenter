//
//  TLTagsControl.h
//  CourseCenter
//
//  Created by 2345 on 15/7/18.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//
#import <UIKit/UIKit.h>

@class TLTagsControl;

@protocol TLTagsControlDelegate <NSObject>

- (void)tagsControl:(TLTagsControl *)tagsControl tappedAtIndex:(NSInteger)index;

@end

typedef NS_ENUM(NSUInteger, TLTagsControlMode) {
    TLTagsControlModeEdit,
    TLTagsControlModeList,
};

@interface TLTagsControl : UIScrollView

@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) UIColor *tagsBackgroundColor;
@property (nonatomic, strong) UIColor *tagsTextColor;
@property (nonatomic, strong) UIColor *tagsDeleteButtonColor;
@property (nonatomic, strong) NSString *tagPlaceholder;
@property (nonatomic) TLTagsControlMode mode;

@property (assign, nonatomic) id<TLTagsControlDelegate> tapDelegate;

- (id)initWithFrame:(CGRect)frame andTags:(NSArray *)tags withTagsControlMode:(TLTagsControlMode)mode;

- (void)addTag:(NSString *)tag;
- (void)reloadTagSubviews;

@end