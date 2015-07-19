//
//  MyData.m
//  CourseCenter
//
//  Created by 2345 on 15/7/18.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "MyData.h"
#import "CourseData.h"
#import "DetailData.h"
@interface MyData ()
{
    UISegmentedControl *seg;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MyData

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *array = @[@"课程资料",@"我的资料"];
    seg = [[UISegmentedControl alloc] initWithItems:array];
    seg.selectedSegmentIndex = 0;
    seg.bounds = CGRectMake(0, 0, 160, 30);
    [seg addTarget:self action:@selector(segValueChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = seg;
    self.tableView.tableFooterView=[[UIView alloc]init];
}
- (void)segValueChange:(UISegmentedControl *)myseg {
    if (myseg.selectedSegmentIndex == 0) {
        [_tableView reloadData];
    }
    else {
        [_tableView reloadData];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (seg.selectedSegmentIndex) {
        case 0:
            return 10;
        case 1:
            return 4;
        default:
            return 10;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier1 = @"cell1";
    static NSString *cellIndentifier2 = @"cell2";
    UITableViewCell *cell =seg.selectedSegmentIndex==0? [tableView dequeueReusableCellWithIdentifier:cellIndentifier1]:[tableView dequeueReusableCellWithIdentifier:cellIndentifier2];
    if (!cell) {
        cell =seg.selectedSegmentIndex==0?[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier1]:[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier2];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"大学英语-%ld-%ld",indexPath.section,indexPath.row];
    if (seg.selectedSegmentIndex==1) {
        cell.imageView.image=[UIImage imageNamed:@"icon_video1"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (seg.selectedSegmentIndex==0) {
        CourseData *courseData=[[CourseData alloc]init];
        [((AppDelegate *)app).nav pushViewController:courseData animated:YES];
    }else
    {
        DetailData *detailData=[[DetailData alloc]init];
        [((AppDelegate *)app).nav pushViewController:detailData animated:YES];
    }
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
