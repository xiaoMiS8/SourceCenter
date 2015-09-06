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
    self.items = @[@[@"登录",@"注销",@"个人信息",@"修改密码"],@[@"推荐课程",@"全部课程",@"学科列表",@"Mooc基本信息",@"课程章节",@"章节下资料列表"],@[@"获取未读消息数",@"发送消息消息列表",@"消息详细",@"发送消息",@"某人所在的所有教学班及组",@"教学班下联系人"],@[@"获取资源分类数量",@"获取某人的课程名称列表",@"获取资料的列表信息"],@[@"翻转课堂列表",@"翻转课堂小组信息",@"获取课堂成员",@"翻转课堂成绩排名",@"翻转课堂导航信息",@"获取翻转课堂详细",@"线上课堂资料列表",@"线上课堂作业列表",@"线上课堂互动列表",@"翻转课堂线下课堂列表",@"翻转课堂小组的成绩统计"],@[@"获取论坛列表",@"论坛主题的详细信息",@"获取论坛回复列表",@"论坛回复",@"论坛版块列表",@"新建讨论板块",@"论坛版块修改",@"发帖",@"删除板块",@"教学班列表",@"为论坛主题或回复点赞",@"删除帖子",@"删除回复",@"获取Mooc章的列表",@"帖子设置置顶",@"帖子设置精华",@"帖子分享到其他板块"]];
    self.titles = @[@"用户",@"首页",@"消息中心",@"我的资料",@"翻转课堂",@"论坛"];
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
//        [self.httpManager getSpecialtyTypeTreeWithParentID:-1 finished:^(EnumServerStatus status, NSObject *object) {
//            resultVC.result = [NSString stringWithFormat:@"%@", object];
//        }];
        
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
        [self.httpManager getAppClassUserListwithID:53 Type:1 finished:^(EnumServerStatus status, NSObject *object) {
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
      [self.httpManager getAppFileSearchwithSearchkey:nil OCID:161 FileType:1 PageIndex:1 PageSize:INT_MAX finished:^(EnumServerStatus status, NSObject *object) {
          resultVC.result = [NSString stringWithFormat:@"%@",object];
      }];
    } else if ([cell.textLabel.text isEqualToString:@"翻转课堂列表"]) {
        [self.httpManager getAppOCFCListWithOCID:570 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"翻转课堂小组信息"]) {
        [self.httpManager getAppFCGroupWithOCID:570 FCID:175 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"获取课堂成员"]) {
        [self.httpManager getAppFCGroupUserListWithOCID:570 FCID:175 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"翻转课堂成绩排名"]) {
        [self.httpManager getAppOCFCScoreRankWithFCID:175 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"翻转课堂导航信息"]) {
        [self.httpManager getOCFCLearnNavInfowithOCID:570 FCID:175 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"获取翻转课堂详细"]) {
        [self.httpManager getAppOCFCWithFCID:175 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"线上课堂资料列表"]) {
        [self.httpManager getOCFCFileListWithFCID:175 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"线上课堂作业列表"]) {
        [self.httpManager getOCFCLiveTestListWithFCID:175 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"线上课堂互动列表"]) {
        [self.httpManager getOCFCLiveForumListWithFCID:175 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"翻转课堂线下课堂列表"]) {
        [self.httpManager getOCFCOfflineListWithFCID:175 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"翻转课堂小组的成绩统计"]) {
        [self.httpManager getAppOCFCScoreGroupWithFCID:175 finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    } else if ([cell.textLabel.text isEqualToString:@"获取论坛列表"]) {
        [self.httpManager getAppForumTopicListWithOCID:161 ForumTypeID:1 IsEssence:NO IsMyStart:NO IsMyJoin:NO SearchKey:nil PageIndex:1 PageSize:INT_MAX finished:^(EnumServerStatus status, NSObject *object) {
            resultVC.result = [NSString stringWithFormat:@"%@",object];
        }];
    }
    
    [self.navigationController pushViewController:resultVC animated:YES];
    
   
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
