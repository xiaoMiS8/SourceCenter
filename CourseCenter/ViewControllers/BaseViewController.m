//
//  BaseViewController.m
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

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
- (void)setupCustomBackWithImage:(NSString *)imagename title:(NSString *)title {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    [backItem setBackButtonBackgroundImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    backItem.title = title;
    self.navigationItem.backBarButtonItem = backItem;
}
/**
 *	@brief	设置视图控制器的rightBarButtonItemWithTitle
 *
 *	@param 	title   标题
 *	@param 	tar     事件响应对象
 *	@param 	act     sel事件
 */
- (void)setupCustomRightWithtitle:(NSString *)title target:(id)tar action:(SEL)act
{
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:tar action:act];
    //导航栏左右侧按钮赋值
    self.navigationItem.rightBarButtonItem=rightItem;
}
/**
 *	@brief	设置视图控制器的rightBarButtonItemWithImage
 *
 *	@param 	image   图片
 *	@param 	tar     事件响应对象
 *	@param 	act     sel事件
 */
- (void)setupCustomRightWithImage:(UIImage *)image target:(id)tar action:(SEL)act
{
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:tar action:act];
    //导航栏左右侧按钮赋值
    self.navigationItem.rightBarButtonItem=rightItem;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell-%ld-%ld",indexPath.section,indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
