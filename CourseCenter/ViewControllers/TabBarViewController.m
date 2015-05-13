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
@interface TabBarViewController ()<UITabBarControllerDelegate>

@property(nonatomic, strong) NSArray *viewcontrollers;
@property(nonatomic, strong) NSArray *itemImages;
@property(nonatomic, strong) NSArray *itemSelectedImages;
@property(nonatomic, strong) NSArray *itemTitles;
@property(nonatomic, strong) UISegmentedControl *seg;
@property(nonatomic, strong) UIImageView *centerImg;
@property(nonatomic, strong) UIButton *searchBtn;

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
    
    
  
    
}

- (void)setViewcontrollers:(NSArray *)viewcontrollers itemImages:(NSArray *)itemImages itemselectedImages:(NSArray *)itemselectedImages titles:(NSArray *)titles
{
    _viewcontrollers = viewcontrollers;
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

- (void)initTabbar
{
    self.tabbar = [[UITabBarController alloc] init];
    self.tabbar.delegate = self;
    self.tabbar.view.frame = self.view.frame;
    [self.view addSubview:self.tabbar.view];
}

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
    for (int i=0; i<self.viewcontrollers.count; i++) {
        if (viewController == self.viewcontrollers[i]) {
            self.title = self.itemTitles[i];
        }
    }
    if (viewController == self.viewcontrollers[0]) {
        [self addCenterandRightItem];
    }
    
    else if (viewController == self.viewcontrollers[2]) {
        [self addcenterImg];
    }
    
    else
    {
        [self removeCenterandRightItem];
    }
    
    return YES;
}

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

- (void)removeCenterandRightItem
{
    self.navigationItem.titleView = nil;
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)addcenterImg
{
    if (self.centerImg == nil) {
        UIImageView *img = [[UIImageView alloc] init];
        img.bounds = CGRectMake(0, 0, 40, 40);
        img.backgroundColor = [UIColor purpleColor];
        img.layer.cornerRadius = 20;
        CourseViewController *courseVC = self.viewcontrollers[2];
        courseVC.centerImg = img;
        self.centerImg = img;
    }
    self.navigationItem.titleView = self.centerImg;
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:toInterfaceOrientation];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AnimateRotationToInterfaceOrientation" object:set];
}



@end
