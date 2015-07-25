//
//  CourseViewController.m
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "CourseViewController.h"
#import "MyCourseListCell.h"
#import "CCHttpManager.h"

#import "CourseTabbarViewController.h"
#import "TutorialViewController.h"
#import "FCourseViewController.h"
#import "BBsViewController.h"
#import "HWorkViewController.h"
#import "TPViewController.h"
#import "LineNavigationController.h"

@interface CourseViewController ()
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong) CCHttpManager *manager;
@property(nonatomic, strong) NSMutableArray *OCList;

@end

@implementation CourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initmanager];
    [self setCell];
    [self loadData];
    
  
}

- (void)setCenterImg:(UIImageView *)centerImg {
    _centerImg = centerImg;
     centerImg.image = [UIImage imageNamed:@"iconpro"];
}

- (void)initmanager {
    self.manager = [CCHttpManager new];
}

- (void)loadData {
    [self.manager getAppOCListWithIsHistroy:-1 finished:^(EnumServerStatus status, NSObject *object) {
        ResponseObject *retunObject = (ResponseObject *)object;
        self.OCList = retunObject.resultArray;
        [self.tableView reloadData];
    }];
}

- (void)setCell {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCourseListCell" bundle:nil] forCellReuseIdentifier:@"MyCourseListCell"];
}

#pragma mark- UITableViewDataSource & UITableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.OCList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCourseListCell"];
    cell.oCourse = self.OCList[indexPath.row];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCourseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCourseListCell"];
    cell.oCourse = self.OCList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [((AppDelegate *)app).nav pushViewController:[self setTabbar] animated:YES];
    
}

- (CourseTabbarViewController *)setTabbar {
    CourseTabbarViewController *tabbar = [[CourseTabbarViewController alloc] init];
    TutorialViewController *tutoriaVC = [[TutorialViewController alloc] init];
    tutoriaVC.PushBlock = ^(UIViewController *viewController) {
        [tabbar.navigationController pushViewController:viewController animated:YES];
    };
    FCourseViewController *fCourseVC = [[FCourseViewController alloc] init];
    fCourseVC.PushBlock = ^(UIViewController *viewController) {
        [tabbar.navigationController pushViewController:viewController animated:YES];
    };
    BBsViewController *bbsVC = [[BBsViewController alloc] init];
    bbsVC.PushBlock = ^(UIViewController *viewController) {
        [tabbar.navigationController pushViewController:viewController animated:YES];
    };
    HWorkViewController *hworkVC = [[HWorkViewController alloc] init];
    hworkVC.PushBlock = ^(UIViewController *viewController) {
        [tabbar.navigationController pushViewController:viewController animated:YES];
    };
    TPViewController *tpVC = [[TPViewController alloc] init];
    tpVC.PushBlock = ^(UIViewController *viewController) {
        [tabbar.navigationController pushViewController:viewController animated:YES];
    };
    NSArray *viewControllers = @[tutoriaVC, fCourseVC,bbsVC, hworkVC, tpVC];
    NSArray *titles = @[@"教程",@"翻转课堂",@"论坛",@"作业",@"事务处理"];
    NSArray *itemImages = @[@"cTabbar1_n",@"cTabbar2_n",@"cTabbar3_n",@"cTabbar4_n",@"cTabbar5_n"];
    NSArray *itemSelectedImages = @[@"cTabbar1_s",@"cTabbar2_s",@"cTabbar3_s",@"cTabbar4_s",@"cTabbar5_s"];
    [tabbar setViewcontrollers:viewControllers itemImages:itemImages itemselectedImages:itemSelectedImages titles:titles];
    return tabbar;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
