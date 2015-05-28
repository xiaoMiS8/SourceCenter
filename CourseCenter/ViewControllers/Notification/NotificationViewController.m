//
//  NotificationViewController.m
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotificationListCell.h"
#import "NotificationInfo.h"
@interface NotificationViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *notis;

@end

@implementation NotificationViewController


- (void)setAddBtn:(UIButton *)addBtn {
    _addBtn = addBtn;
    [addBtn addTarget:self
               action:@selector(addBtnAction:)
     forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCell];
    self.notis = [[NSMutableArray alloc] init];
    for (int i= 0; i<60; i++) {
        NotificationInfo *info = [[NotificationInfo alloc] init];
        switch (i) {
            case 0:
            {
                info.name = @"xxijian";
                info.title = @"放假了吧您好，在注册报到后请同学们及时开始课程的在线教程学习。如果到清退截止时间您还没有开始学习，即您的学习进度显示仍旧为";
                info.message = @"学您好，在注册报到后请同学们及时开始课程的在线教程学习。如果到清退截止时间您还没有开始学习，即您的学习进度显示仍旧为零的话，将一律会被平台清退，不能再登录平台继续这门课程的学习。上海地区选课学校：根据上海共享中心与各选课学校的约定，清退的时间按照各选课学校的规定执行，选课学校清退后请及时通知智慧树平台。如果选课学校没有规定的，课程中心平台执行清退的最后截止时间为3月30日24:00点。其它区域的选课学校：如果选课学校有规定的请以正式函的形式通知课程中心平台，若没有特别说明的，课程中心平台统一的最后清退截止时间为4月15日24:00点。";
                info.imgs = @[@"mmw",@"jjgjg",@"22"];
                info.items = @[@"您好，在注册报到后请",@"的，课程中心平台执行清退的最后截止时间为3月30日24:00点。其它区域的选课学校：如果选课学校有规定的请以正式函的形式通知课程中心平"];
            }
                break;
            case 1:
            {
                info.name = @"xxijian";
                info.title = @"放假了吧";
                info.message = @"学您好，在注册报到后请同学们及时开始课程的在线教程学习。如果到清退截止时间您还没有开始学习，即您的学习进度显示仍旧为零的话，将一律会被平台清退，不能再登录平台继续这门课程的学习。上海地区选课学校：根据上海共享中心与各选课学校的约定，清退的时间按照各选课学校的规定执行，选课学校清退后请及时通知智慧树平台。如果选课学校没有规定的，课程中心平台执行清退的最后截止时间为3月30日24:00点。其它区域的选课学校：如果选课学校有规定的请以正式函的形式通知课程中心平台，若没有特别说明的，课程中心平台统一的最后清退截止时间为4月15日24:00点。";
                info.imgs = @[@"mmw",@"jjgjg"];
                info.items = nil;
            }
                break;
            case 2:
            {
                info.name = @"xxijian";
                info.title = @"放假了吧";
                info.message = @"学您好，在注册报到后请同学们及时开始课程的在线教程学习。如果到清退截止时间您还没有开始学习，即您的学习进度显示仍旧为零的话，将一律会被平台清退，不能再登录平台继续这门课程的学习。上海地区选课学校：根据上海共享中心与各选课学校的约定，清退的时间按照各选课学校的规定执行，选课学校清退后请及时通知智慧树平台。如果选课学校没有规定的，课程中心平台执行清退的最后截止时间为3月30日24:00点。其它区域的选课学校：如果选课学校有规定的请以正式函的形式通知课程中心平台，若没有特别说明的，课程中心平台统一的最后清退截止时间为4月15日24:00点。";
                info.imgs = @[@"mmw",@"jjgjg",@"22"];
                info.items = @[@"您好，在注册报到后请",@"的，课程中心平台执行清退的最后截止时间为3月30日24:00点。其它区域的选课学校：如果选课学校有规定的请以正式函的形式通知课程中心平"];
            }
                break;
            case 3:
            {
                info.name = @"xxijian";
                info.title = @"放假了吧";
                info.message = @"学您好，在注册报到后请同学们及时开始课程的在线教程学习。如果到清退截止时间您还没有开始学习，即您的学习进度显示仍旧为零的话，将一律会被平台清退，不能再登录平台继续这门课程的学习。上海地区选课学校：根据上海共享中心与各选课学校的约定，清退的时间按照各选课学校的规定执行，选课学校清退后请及时通知智慧树平台。如果选课学校没有规定的，课程中心平台执行清退的最后截止时间为3月30日24:00点。其它区域的选课学校：如果选课学校有规定的请以正式函的形式通知课程中心平台，若没有特别说明的，课程中心平台统一的最后清退截止时间为4月15日24:00点。";
                info.imgs = nil;
                info.items = @[@"您好，在注册报到后请",@"的，课程中心平台执行清退的最后截止时间为3月30日24:00点。其它区域的选课学校：如果选课学校有规定的请以正式函的形式通知课程中心平"];
            }
                break;
            case 4:
            {
                info.name = @"xxijian";
                info.title = @"放假了吧";
                info.message = @"学您好，";
                info.imgs = @[@"mmw"];
                info.items = @[@"您好，在注册报到后请",@"的，课程中心平台执行清退的最后截止时间为3月30日24:00点。其它区域的选课学校：如果选课学校有规定的请以正式函的形式通知课程中心平"];
            }
                break;
            case 5:
            {
                info.name = @"xxijian";
                info.title = @"放假了吧";
                info.message = @"学您好，在注册报到后";
                info.imgs = @[@"mmw",@"jjgjg",@"22",@"mmw",@"jjgjg",@"22"];
                info.items = @[@"您好，在注册报到后请", @"eeeee",@"平台执行",@"请以正式函的形式通知课程中心"];
            }
                break;
                
            default:
                break;
        }
        [self.notis addObject:info];
        
    }
    
}

- (void)setupCell {
    [self.tableView registerClass:[NotificationListCell class] forCellReuseIdentifier:@"NotificationListCell"];
}

    //添加通知
- (void)addBtnAction:(id)sender {
    
}

#pragma mark- UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notis.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationListCell"];
    cell.notification = self.notis[indexPath.row];
    return cell.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationListCell"];
    cell.notification = self.notis[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
