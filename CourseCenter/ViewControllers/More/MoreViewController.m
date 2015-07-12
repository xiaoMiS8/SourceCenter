//
//  MoreViewController.m
//  CourseCenter
//
//  Created by jian on 15/5/13.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreListCell.h"
#import "MyInfo.h"
#import "SetViewController.h"
@interface MoreViewController ()
{
    NSArray *myarray;
    MyInfo *myInfo;
    SetViewController *set;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (SHeight<=480) {
        _tableHeight.constant=365;
    }else
    {
        _tableHeight.constant=450;
        _tableView.scrollEnabled=NO;
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"MoreListCell" bundle:nil] forCellReuseIdentifier:@"MoreListCell"];
    myInfo=[[MyInfo alloc]init];
    set=[[SetViewController alloc]init];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            return 4;
        case 3:
            return 1;
        default:
            return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 60;
        }
    }
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击松开后,颜色恢复
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            [((AppDelegate *)app).nav pushViewController:myInfo animated:YES];
            break;
        case 3:
            [((AppDelegate *)app).nav pushViewController:set animated:YES];
            break;
        default:
            break;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreListCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"MoreListCell"];
    cell.indexPath=indexPath;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
