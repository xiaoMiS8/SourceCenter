//
//  TabBarViewController.m
//  CustomTab
//
//  Created by renxiaojian on 15/4/16.
//  Copyright (c) 2015年 renxiaojian. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "CourseViewController.h"
#import "NotificationViewController.h"
@interface TabBarViewController ()<UITabBarControllerDelegate>

@property(nonatomic, strong) NSArray *viewcontrollers;
@property(nonatomic, strong) NSArray *itemImages;
@property(nonatomic, strong) NSArray *itemSelectedImages;
@property(nonatomic, strong) NSArray *itemTitles;
@property(nonatomic, strong) UISegmentedControl *seg;
@property(nonatomic, strong) UIImageView *centerImg;
@property(nonatomic, strong) UIButton *searchBtn;
@property(nonatomic, strong) UIButton *addBtn;

@end

@implementation TabBarViewController


- (id)init
{
    self = [super init];
    if (self) {
        [self initTabbar];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCustomBackWithImage:@"barbuttonItem_back" title:@""];
}

/**
 *	@brief	设置视图控制器的backBarButtonItem
 *
 *	@param 	imagename 	图片
 *	@param 	title 	标题
 */
- (void)setupCustomBackWithImage:(NSString *)imagename title:(NSString *)title

{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    [backItem setBackButtonBackgroundImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    backItem.title = title;
    self.navigationItem.backBarButtonItem = backItem;
}

/**
 *	@brief	初始化相关
 *
 *	@param 	viewcontrollers 	试图控制器对象数组
 *	@param 	itemImages 	图片数组
 *	@param 	itemselectedImages 	高亮图片数组
 *	@param 	titles 	标题数组
 */
- (void)setViewcontrollers:(NSArray *)viewcontrollers itemImages:(NSArray *)itemImages itemselectedImages:(NSArray *)itemselectedImages titles:(NSArray *)titles

{
    self.viewcontrollers = viewcontrollers;
    self.itemImages = itemImages;
    self.itemSelectedImages = itemselectedImages;
    self.itemTitles = titles;
    self.title = [self.itemTitles firstObject];
    [self setupTabbar];
    [self addCenterandRightItem];
    
}

- (void)setSelectedIndex:(int)selectedIndex
{
    _selectedIndex = selectedIndex;
}

- (void)settabbarTintColor:(UIColor *)color
{
    [self.tabbar.tabBar setTintColor:color];
}

/**
 *	@brief	初始化UITabBarController
 */
- (void)initTabbar

{
    self.tabbar = [[UITabBarController alloc] init];
    self.tabbar.delegate = self;
    self.tabbar.view.frame = self.view.frame;
    [self.view addSubview:self.tabbar.view];
}

/**
 *	@brief	设置tabBar.items
 */
- (void)setupTabbar

{
   
    self.tabbar.viewControllers = self.viewcontrollers;
    for (int i=0; i<self.viewcontrollers.count; i++) {
        [(UITabBarItem *)self.tabbar.tabBar.items[i] setTitle:self.itemTitles[i]];
        [(UITabBarItem *)self.tabbar.tabBar.items[i] setImage:[UIImage imageNamed:self.itemImages[i]]];
        [(UITabBarItem *)self.tabbar.tabBar.items[i] setSelectedImage:[UIImage imageNamed:self.itemSelectedImages[i]]];
    }
    
}

- (void)settabbarBackgroundImage:(UIImage *)image
{
    [self.tabbar.tabBar setBackgroundImage:image];
}

#pragma mark- UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSString *nowLoginState =[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"];
    for (int i=0; i<self.viewcontrollers.count; i++) {
        if (viewController == self.viewcontrollers[i]) {
            self.title = self.itemTitles[i];
        }
    }
    if (viewController == self.viewcontrollers[0]) {
        [self addCenterandRightItem];
        if (![_OneLoginState isEqualToString:nowLoginState]) {
            [viewController viewDidLoad];
            _OneLoginState=nowLoginState;
        }
    }
    else if (viewController == self.viewcontrollers[1]) {
        [self removeCenterandRightItem];
        [self addNotificationRightItem];
        if (![_TowLoginState isEqualToString:nowLoginState]) {
            [viewController viewDidLoad];
            _TowLoginState=nowLoginState;
        }
    }
    else if (viewController == self.viewcontrollers[2]) {
        [self removeNotificationRightItem];
        [self addcenterImg];
        if (![_ThreeLoginState isEqualToString:nowLoginState]) {
            [viewController viewDidLoad];
            _ThreeLoginState=nowLoginState;
        }
    }
    else if (viewController == self.viewcontrollers[3])
    {
        [self removeCenterandRightItem];
        [self removeNotificationRightItem];
        if (![_FourLoginState isEqualToString:nowLoginState]) {
            [viewController viewDidLoad];
            _FourLoginState=nowLoginState;
        }
    }
    return YES;
}

/**
 *	@brief	设置首页navigationItem
 */
- (void)addCenterandRightItem

{
    HomeViewController *homeVC = self.viewcontrollers[0];
    if (self.seg == nil) {
        NSArray *array = @[@"推荐课程",@"全部课程"];
        UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:array];
        seg.selectedSegmentIndex = 0;
        seg.bounds = CGRectMake(0, 0, 160, 30);
        homeVC.seg = seg;
        self.seg = seg;
    }
    if (self.searchBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.bounds = CGRectMake(0, 0, 44, 44);
        [btn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        homeVC.searchBtn = btn;
        self.searchBtn = btn;
        
    }
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBtn];
    self.navigationItem.rightBarButtonItem = searchItem;
    self.navigationItem.titleView = self.seg;
}

/**
 *  添加通知界面右Item
 */
- (void)addNotificationRightItem {
    NotificationViewController *notificationVC = self.viewcontrollers[1];
    if (self.addBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.bounds = CGRectMake(0, 0, 30, 30);
        [btn setBackgroundImage:[UIImage imageNamed:@"notification_add"] forState:UIControlStateNormal];
        notificationVC.addBtn = btn;
        self.addBtn = btn;
    }
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithCustomView:self.addBtn];
    self.navigationItem.rightBarButtonItem = addItem;
}

- (void)removeNotificationRightItem {
    self.navigationItem.titleView = nil;
    self.navigationItem.rightBarButtonItem = nil;
}

/**
 *	@brief	取消首页navigationItem
 */
- (void)removeCenterandRightItem
{
    self.navigationItem.titleView = nil;
    self.navigationItem.rightBarButtonItem = nil;
}


/**
 *	@brief	设置课程navigationItem
 */
- (void)addcenterImg
{
    UIView *imgView=[[UIView alloc]init];
    imgView.frame=CGRectMake(0, 0, 0, 40);
    if (self.centerImg == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        img.frame = CGRectMake((self.navigationItem.titleView.frame.size.height-40)/2,0,40, 40);
        img.backgroundColor = [UIColor purpleColor];
        img.layer.cornerRadius = 20;
        img.layer.masksToBounds=YES;
        CourseViewController *courseVC = self.viewcontrollers[2];
        courseVC.centerImg = img;
        self.centerImg = img;
        [imgView addSubview:img];
    }
    self.navigationItem.titleView = imgView;
 
}

/**
 *	@brief	屏幕翻转后调用
 *
 *	@param 	toInterfaceOrientation 	用户界面的新取向
 *	@param 	duration 	等待旋转的持续时间
 */
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration

{
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:toInterfaceOrientation];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AnimateRotationToInterfaceOrientation" object:set];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}




@end
