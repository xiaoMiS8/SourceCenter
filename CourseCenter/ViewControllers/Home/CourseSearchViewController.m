//
//  CourseSearchViewController.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/26.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "CourseSearchViewController.h"
#import "ResponseObject.h"
#import "SpecialtyTypeInfo.h"
#import "SubjectSearchViewController.h"
@interface CourseSearchViewController ()
{
    SpecialtyTypeInfo *specialtyinfo;
}
@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CourseSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课程搜索";
    [self addTableviewHeader];
    self.httpManager = [[CCHttpManager alloc]init];
    self.dataArray=[[NSMutableArray array]init];
    [self loadData];
}
-(void)loadData
{
    [self.httpManager getSpecialtyTypeTreeWithParentID:-1 finished:^(EnumServerStatus status, NSObject *object) {
        if (status==0) {
            self.reob=(ResponseObject *)object;
            if ([self.reob.errrorCode isEqualToString:@"0"]) {
                self.dataArray=self.reob.resultArray;
                [_tableView reloadData];
            }
        }
    }];
}
- (void)addTableviewHeader
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
    searchBar.placeholder = @"这里可以搜索您感兴趣的视频课程哦！";
    self.tableView.tableHeaderView = searchBar;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text =((SpecialtyTypeInfo *)[_dataArray objectAtIndex:indexPath.row]).SpecialtyTypeName;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SubjectSearchViewController *subjectSearchVC = [SubjectSearchViewController new];
    subjectSearchVC.title=((SpecialtyTypeInfo *)[_dataArray objectAtIndex:indexPath.row]).SpecialtyTypeName;
    subjectSearchVC.SpecialtyTypeID=((SpecialtyTypeInfo *)[_dataArray objectAtIndex:indexPath.row]).SpecialtyTypeID;
    [((AppDelegate *)app).nav pushViewController:subjectSearchVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
