//
//  CourseTabbarViewController.m
//  CourseCenter
//
//  Created by jian on 15/7/25.
//  Copyright © 2015年 line0.com. All rights reserved.
//

#import "CourseTabbarViewController.h"

@interface CourseTabbarViewController ()<UITabBarControllerDelegate>

@property(nonatomic, strong) NSArray *viewcontrollers;
@property(nonatomic, strong) NSArray *itemImages;
@property(nonatomic, strong) NSArray *itemSelectedImages;
@property(nonatomic, strong) NSArray *itemTitles;

@property(nonatomic, strong) UISegmentedControl *seg;
@property(nonatomic, strong) UIButton *oneBtn;
@property(nonatomic, strong) UIButton *rightBtn;

@end

@implementation CourseTabbarViewController


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

- (void)addCenterSeg {
    if ([self.viewcontrollers[3] isKindOfClass:[HWorkViewController class]]) {
        HWorkViewController *hwVC = self.viewcontrollers[3];
        if (self.seg == nil) {
            NSArray *array = @[@"未上交",@"已上交"];
            UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:array];
            seg.selectedSegmentIndex = 0;
            seg.bounds = CGRectMake(0, 0, 160, 30);
            hwVC.seg = seg;
            self.seg = seg;
        }
        self.navigationItem.titleView = self.seg;
    }
  
}

- (void)removeCenterSeg {
    self.navigationItem.titleView = nil;
}

- (void)addrightItemsWithIsTwo:(BOOL)isTwo andViewcontroller:(UIViewController *)viewController {
    
    BBsViewController *bbsVC = self.viewcontrollers[2];
    TPViewController *tpVC = self.viewcontrollers[4];
    if (self.oneBtn == nil) {
        UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        Btn.frame = CGRectMake(0, 0, 30, 30);
        [Btn setImage: [UIImage imageNamed:@"btn_plate"] forState:UIControlStateNormal];
        self.oneBtn = Btn;
    }
    bbsVC.rightBtn1 = self.oneBtn;
    if (self.rightBtn == nil) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(0, 0, 30, 30);
        self.rightBtn = rightBtn;
    }
    if (viewController == self.viewcontrollers[2]) {
        bbsVC.rightBtn2 = self.rightBtn;
    } else {
        tpVC.rightBtn = self.rightBtn;
    }
    if (isTwo) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.oneBtn];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
        self.navigationItem.rightBarButtonItems = @[rightItem,item];
    } else {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
  
    
}

- (void)removeRightItem {
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.rightBarButtonItems = nil;
}

- (void)setViewcontrollers:(NSArray *)viewcontrollers itemImages:(NSArray *)itemImages itemselectedImages:(NSArray *)itemselectedImages titles:(NSArray *)titles
{
    _viewcontrollers = viewcontrollers;
    self.itemImages = itemImages;
    self.itemSelectedImages = itemselectedImages;
    self.itemTitles = titles;
    self.title = [self.itemTitles firstObject];
    [self setupTabbar];
    
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
            if (i == 2) {
                self.title = @"话题广场";
            }
        }
    }
    
    if (viewController == self.viewcontrollers[3]) {
        [self addCenterSeg];
        [self removeRightItem];
    } else if (viewController == self.viewcontrollers[2]) {
        [self removeRightItem];
        [self addrightItemsWithIsTwo:YES andViewcontroller:viewController];
        [self removeCenterSeg];
    } else if (viewController == self.viewcontrollers[4]) {
        [self removeRightItem];
        [self addrightItemsWithIsTwo:NO andViewcontroller:viewController];
        [self removeCenterSeg];
    } else {
        [self removeRightItem];
        [self removeCenterSeg];
    }
    
    return YES;
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
