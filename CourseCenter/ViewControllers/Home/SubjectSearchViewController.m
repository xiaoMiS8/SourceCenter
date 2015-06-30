//
//  SubjectSearchViewController.m
//  CourseCenter
//
//  Created by 2345 on 15/6/30.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "SubjectSearchViewController.h"
#import "SubjectSearchCell.h"
#import "ResponseObject.h"
#import "HomeDetailViewController.h"
@interface SubjectSearchViewController ()

@property (strong,nonatomic)CCHttpManager *httpManager;
@property (strong,nonatomic)ResponseObject *reob;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SubjectSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"SubjectSearchCell" bundle:nil] forCellReuseIdentifier:@"SubjectSearchCell"];
    [self addTableviewHeader];
    self.httpManager = [[CCHttpManager alloc]init];
    self.dataArray=[[NSMutableArray array]init];
    [self loadData];
}
-(void)loadData
{
    [self.httpManager getOCAllListWithSpecialtyTypeID:self.SpecialtyTypeID key:nil PageIndex:1 PageSize:INT_MAX finished:^(EnumServerStatus status, NSObject *object) {
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
    SubjectSearchCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"SubjectSearchCell"];
    cell.oCourse=[self.dataArray objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeDetailViewController *homeDetailVc = [[HomeDetailViewController alloc]init];
    homeDetailVc.OCID=1;//((OCourse *)[self.dataArray objectAtIndex:indexPath.row]).OCID;
    homeDetailVc.teacherImgUrl=((OCourse *)[self.dataArray objectAtIndex:indexPath.row]).TeacherImgUrl;
    [((AppDelegate *)app).nav pushViewController:homeDetailVc animated:YES];
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
