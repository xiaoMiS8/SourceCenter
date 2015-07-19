//
//  TabBarViewController.h
//  CustomTab
//
//  Created by renxiaojian on 15/4/16.
//  Copyright (c) 2015年 renxiaojian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarViewController : UIViewController

@property(nonatomic, strong) UITabBarController *tabbar;
@property(nonatomic, assign) int selectedIndex;
@property(nonatomic, strong) NSString *OneLoginState;
@property(nonatomic, strong) NSString *TowLoginState ;
@property(nonatomic, strong) NSString *ThreeLoginState ;
@property(nonatomic, strong) NSString *FourLoginState ;

/**
 *  配置tabbar
 *
 *  @param viewcontrollers    要添加的试图控制器
 *  @param itemImages         tabbar的item图片
 *  @param itemselectedImages tabar被选择后的图片
 *  @param titles             tabbarItemritles
 */
- (void)setViewcontrollers:(NSArray *)viewcontrollers itemImages:(NSArray *)itemImages itemselectedImages:(NSArray *)itemselectedImages titles:(NSArray *)titles;

/**
 *	@brief	设置tabbar的背景图片
 *
 *	@param 	image 	背景图片
 */
- (void)settabbarBackgroundImage:(UIImage *)image;


/**
 *	@brief	设置tabBar的按钮上的字体颜色
 *
 *	@param 	color 	颜色
 */
- (void)settabbarTintColor:(UIColor *)color;



@end
