//
//  CourseTabbarViewController.h
//  CourseCenter
//
//  Created by jian on 15/7/25.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBsViewController.h"

@interface CourseTabbarViewController :BaseViewController

@property(nonatomic, strong) UITabBarController *tabbar;
@property(nonatomic, assign) int selectedIndex;


/**
 *  配置tabbar
 *
 *  @param viewcontrollers    要添加的试图控制器
 *  @param itemImages         tabbar的item图片
 *  @param itemselectedImages tabar被选择后的图片
 *  @param titles             tabbarItemritles
 */
- (void)setViewcontrollers:(NSArray *)viewcontrollers itemImages:(NSArray *)itemImages itemselectedImages:(NSArray *)itemselectedImages titles:(NSArray *)titles;

- (void)settabbarBackgroundImage:(UIImage *)image;

- (void)settabbarTintColor:(UIColor *)color;

@end
