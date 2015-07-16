//
//  TestViewController.m
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "TestViewController.h"
#import "HttpTestResultViewController.h"
#import "CCHttpManager.h"
@interface TestViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray *items;
@property(nonatomic, strong) NSArray *titles;
@property(nonatomic, strong) CCHttpManager * httpManager;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"接口测试";
    self.items = @[@[@"登录",@"注销",@"个人信息",@"修改密码"],@[@"推荐课程",@"全部课程",@"学科列表",@"Mooc基本信息",@"课程章节",@"章节下资料列表"],@[@"获取未读消息数",@"发送消息消息列表",@"消息详细",@"发送消息",@"某人所在的所有教学班及组",@"教学班下联系人"],@[@"获取资源分类数量",@"获取某人的课程名称列表",@"获取资料的列表信息"]];
    self.titles = @[@"用户",@"首页",@"消息中心",@"我的资料"];
    self.httpManager = [CCHttpManager new];
}

#pragma mark- UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.items[indexPath.section][indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.titles[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HttpTestResultViewController *resultVC = [HttpTestResultViewController new];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"登录"]) {
        [self.httpManager loginWithLoginName:@"wang1" Pwd:@"1" finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"注销"]) {
        [self.httpManager LogoutWithfinished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@", object];
        }];
        
    } else if ([cell.textLabel.text isEqualToString:@"个人信息"]) {
        [self.httpManager getUserInfoWithfinished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@", object];
        }];
        
    } else if ([cell.textLabel.text isEqualToString:@"修改密码"]) {
        [self.httpManager  updatePassWordWithYpwd:@"111" NPwd:@"1" finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@", object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"推荐课程"]) {
        [self.httpManager getRecommendCourseListWithfinished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@", object];
        }];
        
    } else if ([cell.textLabel.text isEqualToString:@"全部课程"]) {
        [self.httpManager getOCAllListWithSpecialtyTypeID:-1 key:nil PageIndex:1 PageSize:INT_MAX finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@", object];
        }];
        
    } else if ([cell.textLabel.text isEqualToString:@"学科列表"]) {
        [self.httpManager getSpecialtyTypeTreeWithParentID:-1 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@", object];
        }];
        
    } else if ([cell.textLabel.text isEqualToString:@"Mooc基本信息"]) {
        [self.httpManager getAppOCMoocGetWithOCID:2 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@", object];
        }];
        
    } else if ([cell.textLabel.text isEqualToString:@"课程章节"]) {
        [self.httpManager getChapterStudyListwithOCID:1 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@", object];
        }];
        
    } else if ([cell.textLabel.text isEqualToString:@"章节下资料列表"]) {
        [self.httpManager getOCMoocFileStudyListwithOCID:1 ChapterID:1 FileType:2 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@", object];
        }];
        
    } else if ([cell.textLabel.text isEqualToString:@"获取未读消息数"]) {
        [self.httpManager getAppUnReadMessageCountWithfinished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@", object];
            
        }];
        
    } else if ([cell.textLabel.text isEqualToString:@"发送消息消息列表"]) {
        [self.httpManager getAppMessageListWithkey:nil PageIndex:1 PageSize:INT_MAX finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
        
    } else if ([cell.textLabel.text isEqualToString:@"消息详细"]) {
        [self.httpManager getAppMessageWithUserID:183 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"发送消息"]) {
        [self.httpManager addAppMessageWithTitle:@"没电了" Conten:@"还是每天这样的啊" ReceiveUserIDs:@[@183] finished:^(EnumServerStatus status, NSObject *object) {
             resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
        
    } else if ([cell.textLabel.text isEqualToString:@"某人所在的所有教学班及组"]) {
        [self.httpManager getOCClassListWithfinished:^(EnumServerStatus status, NSObject *object) {
             resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
        
    } else if ([cell.textLabel.text isEqualToString:@"教学班下联系人"]) {
        [self.httpManager getAppClassUserListwithID:53 Type:-1 finished:^(EnumServerStatus status, NSObject *object) {
             resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"获取资源分类数量"]) {
        [self.httpManager getAppFileCountWithOCID:161 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"获取某人的课程名称列表"]) {
        [self.httpManager getAppOCNameListWithrole:1 IsHistroy:NO finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"获取资料的列表信息"]) {
      [self.httpManager getAppFileSearchwithSearchkey:nil OCID:161 FileType:-1 PageIndex:1 PageSize:INT_MAX finished:^(EnumServerStatus status, NSObject *object) {
          resultVC.result = [NSString stringWithFormat:@"%@",object];
      }];
    }
    
    
    [self.navigationController pushViewController:resultVC animated:YES];
    
   
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
